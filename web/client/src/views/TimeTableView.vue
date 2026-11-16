<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue';
import { useRouter } from 'vue-router';
import { api, qs } from '../lib/api';
import { addDays, CAR_GROUPS, daysBetween, fmtDate, fmtMoney, fmtTime, MONTHS, today, WEEKDAYS } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const router = useRouter();
const ui = useUi();
const auth = useAuth();

const pref = (k: string, d: string) => { try { return localStorage.getItem(`tt.${k}`) ?? d; } catch { return d; } };
const save = (k: string, v: string) => { try { localStorage.setItem(`tt.${k}`, v); } catch { /* ignore */ } };

const tab = ref('chart');
const from = ref(addDays(today(), -3));
const to = ref(addDays(today(), 30));
const group = ref(pref('group', 'Group 1'));
const carFilter = ref('');
const colWidth = ref(Number(pref('col', '44')));
const cars = ref<any[]>([]);
const reservations = ref<any[]>([]);
const loading = ref(false);

watch(group, (v) => save('group', v));
watch(colWidth, (v) => save('col', String(v)));

const groupOptions = [...CAR_GROUPS, 'All'];
const days = computed(() => {
  const n = Math.max(daysBetween(from.value, to.value) + 1, 1);
  return Array.from({ length: Math.min(n, 400) }, (_, i) => {
    const iso = addDays(from.value, i);
    const [y, m, d] = iso.split('-').map(Number);
    const wd = new Date(y, m - 1, d).getDay();
    return { iso, day: d, month: m, year: y, wd, weekend: wd === 0 || wd === 6, today: iso === today() };
  });
});
const months = computed(() => {
  const out: { label: string; span: number }[] = [];
  for (const d of days.value) {
    const label = `${MONTHS[d.month - 1]} ${d.year}`;
    const last = out[out.length - 1];
    if (last && last.label === label) last.span++;
    else out.push({ label, span: 1 });
  }
  return out;
});

async function load() {
  if (daysBetween(from.value, to.value) < 0) return ui.error(new Error('First date must be before the second date'));
  loading.value = true;
  try {
    const r = await api.get(`/api/timetable${qs({ from: from.value, to: to.value, group: group.value === 'All' ? '' : group.value, car: carFilter.value })}`);
    cars.value = r.cars;
    reservations.value = r.reservations;
  } catch (e) {
    ui.error(e);
  } finally {
    loading.value = false;
  }
}

// ---- bar geometry: position by date + time, so half days show like the original two columns per day ----
function frac(date: string, time: string) {
  const t = fmtTime(time) || '00:00';
  const [h, m] = t.split(':').map(Number);
  return daysBetween(from.value, date.slice(0, 10)) + (h * 60 + m) / 1440;
}
const barsByCar = computed(() => {
  const map = new Map<number, any[]>();
  const total = days.value.length;
  let alt = 0;
  for (const r of reservations.value) {
    const s = Math.max(frac(r.BirakilacakTarih, r.BirakilacakSaat), 0);
    const e = Math.min(frac(r.AlinacakTarih, r.AlinacakSaat), total);
    if (e <= 0 || s >= total) continue;
    const t = today();
    let cls = alt++ % 2 ? 'b-a' : 'b-b';
    if (Number(r.ExtensionDays) !== 0) cls = 'b-ext';
    if (r.BirakilacakTarih.slice(0, 10) === t) cls = 'b-deliver';
    if (r.AlinacakTarih.slice(0, 10) === t) cls = 'b-collect';
    const daysN = Number(r.LowSeasonDays) + Number(r.MidSeasonDays) + Number(r.HighSeasonDays);
    const bar = {
      r, cls,
      left: s * colWidth.value,
      width: Math.max((e - s) * colWidth.value - 2, 6),
      label: `${r.Name ?? ''} ${r.Surname ?? ''}`.trim(),
      title:
        `#${r.id} ${r.Name} ${r.Surname}\n` +
        `Deliver: ${fmtDate(r.BirakilacakTarih)} ${r.DeliverTimeChecked === 'Y' ? fmtTime(r.BirakilacakSaat) : '??'} ${r.birakilacakYer ?? ''}\n` +
        `Collect: ${fmtDate(r.AlinacakTarih)} ${r.CollectTimeChecked === 'Y' ? fmtTime(r.AlinacakSaat) : '??'} ${r.AlinacakYer ?? ''}\n` +
        `${daysN} days · ${r.ContactNumber ?? ''}\n` +
        (Number(r.OutstandingBalance) ? `Balance: ${fmtMoney(r.OutstandingBalance, r.currency)}\n` : '') +
        (r.Notes ?? ''),
    };
    if (!map.has(r.Carid)) map.set(r.Carid, []);
    map.get(r.Carid)!.push(bar);
  }
  return map;
});

// ---- interactions ----
const selection = ref<{ carId: number; start: string } | null>(null);
const moving = ref<any | null>(null);
const menu = ref<{ r: any } | null>(null);

function cellClick(car: any, iso: string) {
  if (moving.value) return;
  if (!auth.can('timetable')) return;
  if (!selection.value || selection.value.carId !== car.id) {
    selection.value = { carId: car.id, start: iso };
    return;
  }
  const a = selection.value.start;
  const [s, e] = a <= iso ? [a, iso] : [iso, a];
  selection.value = null;
  router.push({ path: '/reservations/new', query: { carId: car.id, from: s, to: e === s ? addDays(s, 1) : e } });
}
function isSelected(car: any, iso: string) {
  return selection.value?.carId === car.id && selection.value?.start === iso;
}

async function carRowClick(car: any) {
  if (!moving.value) return;
  const r = moving.value;
  if (r.Carid === car.id) { moving.value = null; return; }
  if (!(await ui.ask(`Move reservation #${r.id} (${r.Name} ${r.Surname}) to ${car.Model} ${car.RegNo}?`))) return;
  try {
    await api.post(`/api/reservations/${r.id}/move`, { carId: car.id });
    ui.ok('Reservation moved');
    moving.value = null;
    load();
  } catch (e) {
    ui.error(e);
  }
}

function openMenu(bar: any) { menu.value = { r: bar.r }; }
function startMove() { moving.value = menu.value!.r; menu.value = null; }
function extend() {
  const r = menu.value!.r;
  menu.value = null;
  router.push({ path: '/reservations/new', query: { extendFrom: r.id } });
}

// ---- car colours (right part of the original grid) ----
const colorCar = ref<any | null>(null);
const colorForm = ref({ Color: '', FontColor: '' });
function editColors(car: any) {
  colorCar.value = car;
  colorForm.value = { Color: toHex(car.Color) || '#ffffff', FontColor: toHex(car.FontColor) || '#000000' };
}
async function saveColors() {
  try {
    await api.patch(`/api/cars/${colorCar.value.id}/colors`, colorForm.value);
    Object.assign(colorCar.value, colorForm.value);
    colorCar.value = null;
  } catch (e) {
    ui.error(e);
  }
}
/** Delphi colours are stored like "clYellow" or "$00BBGGRR"; convert what we can to CSS. */
const DELPHI: Record<string, string> = {
  clblack: '#000000', clmaroon: '#800000', clgreen: '#008000', clolive: '#808000', clnavy: '#000080', clpurple: '#800080',
  clteal: '#008080', clgray: '#808080', clsilver: '#c0c0c0', clred: '#ff0000', cllime: '#00ff00', clyellow: '#ffff00',
  clblue: '#0000ff', clfuchsia: '#ff00ff', claqua: '#00ffff', clwhite: '#ffffff', clmoneygreen: '#c0dcc0', clskyblue: '#a6caf0',
  clcream: '#fffbf0', clmedgray: '#a4a0a0', clwindow: '#ffffff', clbtnface: '#f0f0f0',
};
function toHex(v?: string | null) {
  if (!v) return '';
  const s = v.trim();
  if (/^#[0-9a-f]{6}$/i.test(s)) return s;
  if (DELPHI[s.toLowerCase()]) return DELPHI[s.toLowerCase()];
  const m = /^\$?([0-9a-f]{2})?([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i.exec(s);
  if (m) return `#${m[4]}${m[3]}${m[2]}`;
  const n = Number(s);
  if (Number.isInteger(n) && n >= 0) {
    const h = n.toString(16).padStart(6, '0');
    return `#${h.slice(4, 6)}${h.slice(2, 4)}${h.slice(0, 2)}`;
  }
  return '';
}

// ---- daily lists ----
const listDate = ref(today());
const dayData = ref<any>(null);
async function loadDay() {
  try {
    dayData.value = await api.get(`/api/timetable/day?date=${listDate.value}`);
  } catch (e) {
    ui.error(e);
  }
}
watch(tab, (t) => { if (t === 'day' && !dayData.value) loadDay(); });

function shift(n: number) {
  from.value = addDays(from.value, n);
  to.value = addDays(to.value, n);
  load();
}

const printPage = () => window.print();

onMounted(load);
</script>

<template>
  <div class="page tt-page">
    <div class="page-header">
      <h1>Time Table</h1>
      <Button label="New reservation" icon="pi pi-plus" @click="router.push('/reservations/new')" />
    </div>

    <Tabs v-model:value="tab">
      <TabList>
        <Tab value="chart"><i class="pi pi-th-large" /> Chart</Tab>
        <Tab value="day"><i class="pi pi-list" /> Daily lists</Tab>
      </TabList>
      <TabPanels>
        <TabPanel value="chart">
          <div class="toolbar">
            <div class="field"><label>From</label><input v-model="from" type="date" class="p-inputtext" /></div>
            <div class="field"><label>To</label><input v-model="to" type="date" class="p-inputtext" /></div>
            <div class="field"><label>Car (reg. no / model)</label><InputText v-model="carFilter" placeholder="e.g. HZ" @keyup.enter="load" /></div>
            <div class="field">
              <label>Column width</label>
              <Select v-model="colWidth" :options="[24, 32, 44, 60, 80]" style="width: 90px" />
            </div>
            <Button icon="pi pi-chevron-left" outlined aria-label="Earlier" @click="shift(-14)" />
            <Button icon="pi pi-search" label="List" :loading="loading" @click="load" />
            <Button icon="pi pi-chevron-right" outlined aria-label="Later" @click="shift(14)" />
          </div>
          <SelectButton v-model="group" :options="groupOptions" :allow-empty="false" class="groups" @change="load" />

          <Message v-if="moving" severity="info" :closable="false" class="mt">
            Moving reservation #{{ moving.id }} ({{ moving.Name }} {{ moving.Surname }}): click the target car on the left.
            <Button label="Cancel" size="small" text @click="moving = null" />
          </Message>
          <Message v-else-if="selection" severity="secondary" :closable="false" class="mt">
            Start {{ fmtDate(selection.start) }} selected. Click the end day on the same car to create a reservation.
            <Button label="Cancel" size="small" text @click="selection = null" />
          </Message>
          <p v-else class="muted hint">Click a start day and an end day on a car's row to create a reservation. Click a booking to open it.</p>

          <div class="tt-scroll card" :style="{ '--cw': colWidth + 'px' }">
            <table class="tt">
              <thead>
                <tr>
                  <th class="car-col sticky" rowspan="3">Car</th>
                  <th v-for="m in months" :key="m.label" :colspan="m.span" class="month">{{ m.label }}</th>
                </tr>
                <tr>
                  <th v-for="d in days" :key="d.iso" :class="{ today: d.today, weekend: d.weekend, first: d.day === 1 }">{{ d.day }}</th>
                </tr>
                <tr>
                  <th v-for="d in days" :key="d.iso" class="wd" :class="{ today: d.today, weekend: d.weekend, first: d.day === 1 }">{{ WEEKDAYS[d.wd].slice(0, 2) }}</th>
                </tr>
              </thead>
              <tbody>
                <tr v-if="!cars.length"><td class="car-col sticky muted" :colspan="days.length + 1">No cars in this group.</td></tr>
                <tr v-for="car in cars" :key="car.id">
                  <th class="car-col sticky car-name" :class="{ target: moving }"
                    :style="{ background: toHex(car.Color) || undefined, color: toHex(car.FontColor) || undefined }"
                    @click="carRowClick(car)">
                    <span>{{ car.Model }} <small>({{ (car.Type || '').slice(0, 1) }})</small></span>
                    <b>{{ car.RegNo }}</b>
                    <button v-if="auth.can('cars') && !moving" class="color-btn no-print" title="Car colours" @click.stop="editColors(car)"><i class="pi pi-palette" /></button>
                  </th>
                  <td class="lane" :colspan="days.length">
                    <div class="cells">
                      <div v-for="d in days" :key="d.iso" class="cell"
                        :class="{ today: d.today, weekend: d.weekend, first: d.day === 1, sel: isSelected(car, d.iso) }"
                        @click="cellClick(car, d.iso)" />
                    </div>
                    <button v-for="b in barsByCar.get(car.id) ?? []" :key="b.r.id" class="bar" :class="b.cls"
                      :style="{ left: b.left + 'px', width: b.width + 'px' }" :title="b.title"
                      @click.stop="router.push(`/reservations/${b.r.id}`)" @contextmenu.prevent="openMenu(b)">
                      <span>{{ b.label }}</span>
                      <i class="pi pi-ellipsis-v more" @click.stop="openMenu(b)" />
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="legend">
            <span><i class="b-a" /> Booking</span><span><i class="b-b" /> Booking</span>
            <span><i class="b-deliver" /> Deliver today</span><span><i class="b-collect" /> Collect today</span><span><i class="b-ext" /> Extension</span>
          </div>
        </TabPanel>

        <TabPanel value="day">
          <div class="toolbar">
            <Button icon="pi pi-chevron-left" outlined aria-label="Previous day" @click="listDate = addDays(listDate, -1); loadDay()" />
            <input v-model="listDate" type="date" class="p-inputtext" @change="loadDay" />
            <Button icon="pi pi-chevron-right" outlined aria-label="Next day" @click="listDate = addDays(listDate, 1); loadDay()" />
            <Button label="Print" icon="pi pi-print" outlined class="no-print" @click="printPage" />
          </div>
          <template v-if="dayData">
            <div class="card">
              <h2>Cars to deliver ({{ dayData.deliveries.length }})</h2>
              <DataTable :value="dayData.deliveries" size="small" row-hover :row-class="() => 'clickable-row'" @row-click="(e: any) => router.push(`/reservations/${e.data.id}`)">
                <template #empty>None</template>
                <Column header="Time"><template #body="{ data }">{{ data.DeliverTimeChecked === 'Y' ? fmtTime(data.BirakilacakSaat) : '??' }}</template></Column>
                <Column header="Customer"><template #body="{ data }">{{ data.Name }} {{ data.Surname }}</template></Column>
                <Column field="ContactNumber" header="Phone" />
                <Column header="Car"><template #body="{ data }">{{ data.CarModel }} {{ data.CarRegNo }}</template></Column>
                <Column field="birakilacakYer" header="Place" />
                <Column header="Flight"><template #body="{ data }">{{ data.FlightNumber }} {{ data.ChkFlightTime === 'Y' ? fmtTime(data.FlightTime) : '' }}</template></Column>
                <Column field="BirakilacakNotlar" header="Notes" />
              </DataTable>
            </div>
            <div class="card">
              <h2>Cars to collect ({{ dayData.collections.length }})</h2>
              <DataTable :value="dayData.collections" size="small" row-hover :row-class="() => 'clickable-row'" @row-click="(e: any) => router.push(`/reservations/${e.data.id}`)">
                <template #empty>None</template>
                <Column header="Time"><template #body="{ data }">{{ data.CollectTimeChecked === 'Y' ? fmtTime(data.AlinacakSaat) : '??' }}</template></Column>
                <Column header="Customer"><template #body="{ data }">{{ data.Name }} {{ data.Surname }}</template></Column>
                <Column field="ContactNumber" header="Phone" />
                <Column header="Car"><template #body="{ data }">{{ data.CarModel }} {{ data.CarRegNo }}</template></Column>
                <Column field="AlinacakYer" header="Place" />
                <Column header="Balance" class="num"><template #body="{ data }">{{ Number(data.OutstandingBalance) ? fmtMoney(data.OutstandingBalance, data.currency) : '' }}</template></Column>
                <Column field="AlinacakNotlar" header="Notes" />
              </DataTable>
            </div>
            <div class="card">
              <h2>Arrivals – transfers & taxi ({{ dayData.arrivals.length + dayData.taxiDeliver.length }})</h2>
              <DataTable :value="[
                ...dayData.arrivals.map((t: any) => ({ src: 'transfer', id: t.id, time: t.ArrivalTimeChecked === 'Y' ? fmtTime(t.ArrivalTime) : '??', name: `${t.Name} ${t.Surname}`, from: t.ArrivalCollectFrom, to: t.ArrivalDestination, pax: t.ArrivalPax, flight: t.ArrivalFlightNo, driver: t.Driver, price: fmtMoney(t.ArrivalPrice, t.Currency), paid: t.ArrivalPaid === 'Y' ? 'Paid ' + (t.ArrivalPaidTo || '') : '', notes: t.ArrivalNotes })),
                ...dayData.taxiDeliver.map((t: any) => ({ src: 'taxi', id: t.id, time: t.ChkTaxiTimeDeliver === 'Y' ? fmtTime(t.TaxiTimeDeliver) : '??', name: `${t.Name} ${t.Surname}`, from: t.TaxiDeliverFrom, to: t.TaxiDeliverTo, pax: t.PaxsPickUp, flight: t.FlightNumber, driver: '', price: fmtMoney(t.TaxiPickUp, t.currency), paid: '', notes: '' })),
              ]" size="small" row-hover :row-class="() => 'clickable-row'" @row-click="(e: any) => router.push(e.data.src === 'taxi' ? `/reservations/${e.data.id}` : `/transfers/${e.data.id}`)">
                <template #empty>None</template>
                <Column field="time" header="Time" /><Column field="name" header="Customer" /><Column field="from" header="From" /><Column field="to" header="To" />
                <Column field="pax" header="Pax" /><Column field="flight" header="Flight" /><Column field="driver" header="Driver" />
                <Column field="price" header="Price" class="num" /><Column field="paid" header="Paid" /><Column field="notes" header="Notes" />
              </DataTable>
            </div>
            <div class="card">
              <h2>Departures – transfers & taxi ({{ dayData.departures.length + dayData.taxiCollect.length }})</h2>
              <DataTable :value="[
                ...dayData.departures.map((t: any) => ({ src: 'transfer', id: t.id, time: t.DepartureTimeChecked === 'Y' ? fmtTime(t.DepartureTime) : '??', name: `${t.Name} ${t.Surname}`, from: t.DepartureCollectFrom, to: t.DepartureDestination, pax: t.DeparturePax, driver: t.Driver, price: fmtMoney(t.DeparturePrice, t.Currency), paid: t.DeparturePaid === 'Y' ? 'Paid ' + (t.PaidTo || '') : '', notes: t.DepartureNotes })),
                ...dayData.taxiCollect.map((t: any) => ({ src: 'taxi', id: t.id, time: t.ChkTaxiTimeCollect === 'Y' ? fmtTime(t.TaxiTimeCollect) : '??', name: `${t.Name} ${t.Surname}`, from: t.TaxiCollectFrom, to: t.TaxiCollectTo, pax: t.PaxsDropOff, driver: '', price: fmtMoney(t.TaxiDropOff, t.currency), paid: '', notes: '' })),
              ]" size="small" row-hover :row-class="() => 'clickable-row'" @row-click="(e: any) => router.push(e.data.src === 'taxi' ? `/reservations/${e.data.id}` : `/transfers/${e.data.id}`)">
                <template #empty>None</template>
                <Column field="time" header="Time" /><Column field="name" header="Customer" /><Column field="from" header="From" /><Column field="to" header="To" />
                <Column field="pax" header="Pax" /><Column field="driver" header="Driver" />
                <Column field="price" header="Price" class="num" /><Column field="paid" header="Paid" /><Column field="notes" header="Notes" />
              </DataTable>
            </div>
          </template>
        </TabPanel>
      </TabPanels>
    </Tabs>

    <Dialog :visible="!!menu" modal header="Reservation" style="width: 340px" @update:visible="menu = null">
      <template v-if="menu">
        <p><b>#{{ menu.r.id }}</b> {{ menu.r.Name }} {{ menu.r.Surname }}<br />
          <span class="muted">{{ fmtDate(menu.r.BirakilacakTarih) }} – {{ fmtDate(menu.r.AlinacakTarih) }}</span></p>
        <div class="menu-actions">
          <Button label="Open" icon="pi pi-folder-open" @click="router.push(`/reservations/${menu.r.id}`)" />
          <Button v-if="auth.can('timetable')" label="Move to another car" icon="pi pi-arrows-v" outlined @click="startMove" />
          <Button v-if="auth.can('timetable')" label="Extension (new booking after this)" icon="pi pi-forward" outlined @click="extend" />
          <Button label="Print" icon="pi pi-print" outlined @click="router.push(`/reservations/${menu.r.id}/print`)" />
        </div>
      </template>
    </Dialog>

    <Dialog :visible="!!colorCar" modal header="Car colours" style="width: 320px" @update:visible="colorCar = null">
      <div v-if="colorCar" class="grid">
        <div class="field"><label>Background</label><input v-model="colorForm.Color" type="color" class="color-input" /></div>
        <div class="field"><label>Text</label><input v-model="colorForm.FontColor" type="color" class="color-input" /></div>
        <div class="field full preview" :style="{ background: colorForm.Color, color: colorForm.FontColor }">{{ colorCar.Model }} {{ colorCar.RegNo }}</div>
      </div>
      <template #footer>
        <Button label="Cancel" text @click="colorCar = null" />
        <Button label="Save" icon="pi pi-check" @click="saveColors" />
      </template>
    </Dialog>
  </div>
</template>

<style scoped>
.tt-page { max-width: none; }
.groups { margin: 4px 0 8px; flex-wrap: wrap; display: flex; }
.hint { font-size: 12px; margin: 6px 0; }
.mt { margin: 8px 0; }
.tt-scroll { overflow: auto; padding: 0; max-height: calc(100vh - 290px); min-height: 240px; }
.tt { border-collapse: separate; border-spacing: 0; font-size: 12px; }
.tt th, .tt td { border-bottom: 1px solid var(--app-border); padding: 0; }
.tt thead th { position: sticky; background: var(--app-surface); z-index: 3; min-width: var(--cw); width: var(--cw); text-align: center; font-weight: 600; height: 22px; border-right: 1px solid var(--app-border); }
.tt thead tr:nth-child(1) th { top: 0; }
.tt thead tr:nth-child(2) th { top: 22px; }
.tt thead tr:nth-child(3) th { top: 44px; }
.tt thead th.month { text-align: left; padding-left: 6px; }
.tt thead th.wd { font-weight: 400; color: var(--app-muted); }
.tt th.today { background: var(--tt-today) !important; }
.tt th.weekend { color: #dc2626; }
.sticky { position: sticky; left: 0; z-index: 4 !important; }
.car-col { min-width: 170px; max-width: 170px; background: var(--app-surface); text-align: left; border-right: 2px solid var(--app-border) !important; }
.car-name { padding: 4px 26px 4px 8px !important; height: 40px; font-weight: 400; position: sticky; cursor: default; }
.car-name span { display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.car-name.target { cursor: pointer; outline: 2px dashed #3b82f6; outline-offset: -3px; }
.color-btn { position: absolute; right: 2px; top: 10px; border: 0; background: transparent; cursor: pointer; color: inherit; opacity: 0.6; }
.lane { position: relative; height: 40px; }
.cells { display: flex; height: 100%; }
.cell { min-width: var(--cw); width: var(--cw); height: 40px; border-right: 1px solid var(--app-border); cursor: cell; }
.cell.weekend { background: var(--tt-weekend); }
.cell.first { border-left: 2px solid #94a3b8; }
.cell.today { background: var(--tt-today); }
.cell.sel { background: #93c5fd; }
.cell:hover { background: #bfdbfe; }
.bar {
  position: absolute; top: 4px; height: 32px; border-radius: 6px; border: 1px solid rgba(0,0,0,0.25); cursor: pointer;
  display: flex; align-items: center; padding: 0 16px 0 6px; overflow: hidden; font-size: 11px; color: #111; text-align: left;
}
.bar span { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.bar .more { position: absolute; right: 2px; font-size: 11px; padding: 4px 1px; }
.b-a { background: #fde047; }
.b-b { background: #b6caea; }
.b-deliver { background: #80ff80; }
.b-collect { background: #f87171; }
.b-ext { background: #facc15; border-style: dashed; }
.legend { display: flex; gap: 14px; flex-wrap: wrap; font-size: 12px; margin-top: 6px; }
.legend i { display: inline-block; width: 14px; height: 10px; border-radius: 3px; vertical-align: middle; border: 1px solid rgba(0,0,0,0.25); }
.menu-actions { display: flex; flex-direction: column; gap: 8px; }
.color-input { width: 100%; height: 40px; border: 1px solid var(--app-border); border-radius: 6px; }
.preview { padding: 10px; border-radius: 6px; border: 1px solid var(--app-border); }
@media (max-width: 640px) {
  .car-col { min-width: 112px; max-width: 112px; }
  .car-name { font-size: 11px; }
  .tt-scroll { max-height: calc(100vh - 200px); }
}
</style>
