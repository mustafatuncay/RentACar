<script setup lang="ts">
import { computed, onMounted, reactive, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import CustomerPicker from '../components/CustomerPicker.vue';
import { api } from '../lib/api';
import { addDays, CURRENCIES, CURRENCY_SYMBOL, fmtDate, fmtMoney, fmtTime, toDateInput, today } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const route = useRoute();
const router = useRouter();
const ui = useUi();
const auth = useAuth();

const id = computed(() => (route.params.id && route.params.id !== 'new' ? Number(route.params.id) : null));
const canEdit = computed(() => auth.can('timetable'));
const loading = ref(false);
const saving = ref(false);
const status = ref('');

const blank = () => ({
  Carid: null as number | null, Customerid: 0,
  Name: '', Surname: '', ContactNumber: '', PassportId: '', LicenseNo: '', PlaceofBirth: '',
  BirakilacakTarih: today(), BirakilacakSaat: '10:00', birakilacakYer: '', BirakilacakNotlar: '', DeliverTimeChecked: 'Y',
  AlinacakTarih: addDays(today(), 7), AlinacakSaat: '10:00', AlinacakYer: '', AlinacakNotlar: '', CollectTimeChecked: 'Y',
  FlightNumber: '', ChkFlightTime: 'N', FlightTime: '00:00', ChkFlightTime2: 'N', DtFlightTime2: '00:00',
  BabySeat: '0', BoosterSeat: '0', infantSeat: '0',
  Agency: '', Company: '', Companyincome: 0, currency: 'STERLIN',
  LowSeasonRate: 0, LowSeasonDays: 0, MidSeasonRate: 0, MidSeasonDays: 0, HighSeasonRate: 0, HighSeasonDays: 0,
  ExtensionRate: 0, ExtensionDays: 0, Dailyinsurance: 0, Lessinsurance: 0, Commission: 0, Petrol: 0, Extra: 0, Discount: 0,
  TaxiDeliverFrom: '', TaxiDeliverTo: '', TaxiDateDeliver: '', TaxiTimeDeliver: '00:00', ChkTaxiTimeDeliver: 'N',
  TaxiCollectFrom: '', TaxiCollectTo: '', TaxiDateCollect: '', TaxiTimeCollect: '00:00', ChkTaxiTimeCollect: 'N',
  TaxiPickUp: 0, TaxiDropOff: 0, PaxsPickUp: 0, PaxsDropOff: 0, Cases: 0,
  ContractNumber: '', VoucherNo: '', RoomNo: '', Notes: '',
  PaymentMethod1: '', PaidAmount1: 0, PaidNote1: '',
  PaymentMethod2: '', PaidAmount2: 0, PaidNote2: '',
  PaymentMethod3: '', PaidAmount3: 0, PaidNote3: '',
  PaymentMethod4: '', PaidAmount4: 0, PaidNote4: '',
});
type Form = ReturnType<typeof blank>;
const f = reactive<Form>(blank());
const totals = reactive({
  TotalDays: 0, LowSeasonTotal: 0, MidSeasonTotal: 0, HighSeasonTotal: 0, ExtensionTotal: 0,
  Totalinsurance: 0, GeneralTotal: 0, TotalComission: 0, OutstandingBalance: 0,
});
const sym = computed(() => CURRENCY_SYMBOL[f.currency] ?? '');

// ---- lookups ----
const cars = ref<any[]>([]);
const agencies = ref<string[]>([]);
const companies = ref<string[]>([]);
const places = ref<{ deliver: string[]; collect: string[] }>({ deliver: [], collect: [] });
const transfer = ref<any | null>(null);
const carOptions = computed(() => cars.value.map((c) => ({ value: c.id, label: `${c.Model} – ${c.RegNo} (${c.Grup}${c.Sold == 1 ? ', sold' : ''})` })));
const seatOptions = ['0', '1', '2', '3', '4'];
const payMethods = ['', 'Cash', 'Credit Card'];
const payNotes = ['', 'Deposit', 'Ext. Deposit'];

/** Load a reservation row into the form (DB values -> form values). */
function fill(r: any) {
  const b = blank();
  for (const k of Object.keys(b) as (keyof Form)[]) {
    if (r[k] === undefined || r[k] === null) continue;
    const def = b[k];
    if (typeof def === 'number') (f as any)[k] = Number(r[k]);
    else if (/Tarih$|^TaxiDate/.test(k)) (f as any)[k] = toDateInput(r[k]);
    else if (/Saat$|Time$|^TaxiTime|FlightTime2$/.test(k)) (f as any)[k] = fmtTime(r[k]) || '00:00';
    else (f as any)[k] = String(r[k]);
  }
  f.Carid = r.Carid ? Number(r.Carid) : null;
}

async function load() {
  loading.value = true;
  try {
    const [c, a, co, p] = await Promise.all([
      api.get('/api/cars?includeSold=1'),
      api.get('/api/agencies'),
      api.get('/api/companies'),
      api.get('/api/reservations/places'),
    ]);
    cars.value = c;
    agencies.value = ['', ...a.map((x: any) => x.name)];
    companies.value = ['', ...co.map((x: any) => x.name)];
    places.value = p;

    if (id.value) {
      const r = await api.get(`/api/reservations/${id.value}`);
      fill(r);
      status.value = r.Durum;
      Object.assign(totals, { TotalDays: Number(r.TotalDays) });
      const t = await api.get(`/api/transfers?reservationId=${id.value}`);
      transfer.value = t[0] ?? null;
      await calc(false);
    } else if (route.query.extendFrom) {
      // "Uzatma": new reservation that starts when the previous one ends, same car and customer.
      const r = await api.get(`/api/reservations/${route.query.extendFrom}`);
      fill(r);
      for (const k of ['PaidAmount1', 'PaidAmount2', 'PaidAmount3', 'PaidAmount4', 'Discount', 'Petrol', 'Extra', 'TaxiPickUp', 'TaxiDropOff', 'ExtensionDays', 'ExtensionRate'] as const) f[k] = 0;
      for (const k of ['PaymentMethod1', 'PaymentMethod2', 'PaymentMethod3', 'PaymentMethod4', 'PaidNote1', 'PaidNote2', 'PaidNote3', 'PaidNote4', 'TaxiDeliverFrom', 'TaxiDeliverTo', 'TaxiCollectFrom', 'TaxiCollectTo', 'ContractNumber'] as const) f[k] = '';
      f.BirakilacakTarih = toDateInput(r.AlinacakTarih);
      f.BirakilacakSaat = fmtTime(r.AlinacakSaat) || '10:00';
      f.AlinacakTarih = addDays(f.BirakilacakTarih, 1);
      f.Notes = `Extension of #${r.id}. ${f.Notes}`.trim();
      await calc(true);
    } else {
      if (route.query.carId) f.Carid = Number(route.query.carId);
      if (typeof route.query.from === 'string') f.BirakilacakTarih = route.query.from;
      if (typeof route.query.to === 'string') f.AlinacakTarih = route.query.to;
      await calc(true);
    }
  } catch (e) {
    ui.error(e);
  } finally {
    loading.value = false;
  }
}

// ---- calculation (server is the single source of truth for the formulas) ----
let calcTimer: ReturnType<typeof setTimeout> | undefined;
async function calc(autoDays: boolean) {
  try {
    const r = await api.post('/api/reservations/calc', { ...pricingPayload(), autoDays });
    if (autoDays) {
      f.LowSeasonDays = r.LowSeasonDays;
      f.MidSeasonDays = r.MidSeasonDays;
      f.HighSeasonDays = r.HighSeasonDays;
    }
    Object.assign(totals, r);
  } catch (e) {
    if (autoDays) ui.error(e);
  }
}
function pricingPayload() {
  const keys = ['BirakilacakTarih', 'BirakilacakSaat', 'AlinacakTarih', 'AlinacakSaat', 'LowSeasonRate', 'LowSeasonDays', 'MidSeasonRate', 'MidSeasonDays',
    'HighSeasonRate', 'HighSeasonDays', 'ExtensionRate', 'ExtensionDays', 'Dailyinsurance', 'Lessinsurance', 'Commission', 'Petrol', 'Extra', 'Discount',
    'TaxiPickUp', 'TaxiDropOff', 'PaidAmount1', 'PaidAmount2', 'PaidAmount3', 'PaidAmount4'] as const;
  return Object.fromEntries(keys.map((k) => [k, f[k]]));
}
const priceWatch = computed(() => JSON.stringify(pricingPayload()));
watch(priceWatch, () => {
  clearTimeout(calcTimer);
  calcTimer = setTimeout(() => calc(false), 300);
});
// Dates changed -> recount days automatically (the original needed the "Days" button).
watch(() => [f.BirakilacakTarih, f.BirakilacakSaat, f.AlinacakTarih, f.AlinacakSaat], () => {
  if (!loading.value) calc(true);
});

function pickCustomer(c: any) {
  f.Customerid = c.id;
  f.Name = c.Name ?? '';
  f.Surname = c.Surname ?? '';
  f.ContactNumber = c.TelNo || c.LocalNumber || c.CyprusMobile || '';
  f.PassportId = c.PassportId ?? '';
  f.LicenseNo = c.LicenseNo ?? '';
  f.PlaceofBirth = c.PlaceofBirth ?? '';
  if (c.BlackList === 'Y') ui.toast.add({ severity: 'warn', summary: 'Black list', detail: 'This customer is on the black list', life: 6000 });
}

const yn = (k: keyof Form) => computed({
  get: () => f[k] === 'Y',
  set: (v: boolean) => ((f as any)[k] = v ? 'Y' : 'N'),
});
const deliverTime = yn('DeliverTimeChecked');
const collectTime = yn('CollectTimeChecked');
const flightTime = yn('ChkFlightTime');
const flightTime2 = yn('ChkFlightTime2');
const taxiTimeDeliver = yn('ChkTaxiTimeDeliver');
const taxiTimeCollect = yn('ChkTaxiTimeCollect');

async function save() {
  if (!f.Carid) return ui.error(new Error('Please select a car'));
  if (!f.Name || !f.Surname) return ui.error(new Error('Please enter the customer name and surname'));
  saving.value = true;
  try {
    const res = await ui.saveWithBlacklist((confirmBlacklist) =>
      id.value
        ? api.put(`/api/reservations/${id.value}`, { ...f, confirmBlacklist })
        : api.post('/api/reservations', { ...f, confirmBlacklist }),
    );
    if (!res) return;
    ui.ok(id.value ? 'Reservation updated' : `Reservation #${res.id} saved`);
    if (!id.value) {
      if (await ui.ask('Do you want to print the reservation?')) router.replace(`/reservations/${res.id}/print`);
      else router.replace(`/reservations/${res.id}`);
    } else {
      load();
    }
  } catch (e) {
    ui.error(e);
  } finally {
    saving.value = false;
  }
}

async function remove() {
  if (!(await ui.ask('Do you want to delete this reservation?', 'Delete', true))) return;
  try {
    await api.del(`/api/reservations/${id.value}`);
    ui.ok('Reservation deleted');
    router.replace('/timetable');
  } catch (e) {
    ui.error(e);
  }
}

function openTransfer() {
  if (transfer.value) router.push(`/transfers/${transfer.value.id}`);
  else router.push({ path: '/transfers/new', query: { reservationId: id.value } });
}

onMounted(load);
</script>

<template>
  <div class="page">
    <div class="page-header">
      <Button icon="pi pi-arrow-left" text rounded aria-label="Back" @click="router.back()" />
      <h1>
        {{ id ? `Reservation #${id}` : route.query.extendFrom ? `Extension of #${route.query.extendFrom}` : 'New reservation' }}
        <Tag v-if="status" :value="status" :severity="status === 'Deleted' ? 'danger' : 'info'" class="ml" />
      </h1>
      <template v-if="id">
        <Button label="Transfer" icon="pi pi-send" outlined @click="openTransfer" />
        <Button label="Print" icon="pi pi-print" outlined @click="router.push(`/reservations/${id}/print`)" />
        <Button v-if="canEdit" label="Extension" icon="pi pi-forward" outlined @click="router.push({ path: '/reservations/new', query: { extendFrom: id } })" />
      </template>
    </div>

    <Message v-if="!canEdit" severity="info" :closable="false" class="mb">You can view this reservation but not change it.</Message>

    <fieldset :disabled="!canEdit || loading" class="plain">
      <section class="card">
        <h2>Car & dates</h2>
        <div class="grid">
          <div class="field span2">
            <label>Car *</label>
            <Select v-model="f.Carid" :options="carOptions" option-label="label" option-value="value" filter placeholder="Select car" :disabled="!canEdit" />
          </div>
          <div class="field"><label>Currency</label><Select v-model="f.currency" :options="[...CURRENCIES]" :disabled="!canEdit" /></div>
          <div class="field"><label>Contract no</label><InputText v-model="f.ContractNumber" /></div>
        </div>
        <div class="two-col">
          <div class="sub">
            <h3><i class="pi pi-sign-out" /> Deliver (start)</h3>
            <div class="grid">
              <div class="field"><label>Date</label><input v-model="f.BirakilacakTarih" type="date" class="p-inputtext" required /></div>
              <div class="field"><label>Time</label><input v-model="f.BirakilacakSaat" type="time" class="p-inputtext" /></div>
              <label class="check"><Checkbox v-model="deliverTime" binary :disabled="!canEdit" /> Time confirmed</label>
              <div class="field span2"><label>Place</label><InputText v-model="f.birakilacakYer" list="deliver-places" /></div>
              <div class="field full"><label>Notes</label><Textarea v-model="f.BirakilacakNotlar" rows="2" auto-resize /></div>
            </div>
          </div>
          <div class="sub">
            <h3><i class="pi pi-sign-in" /> Collect (end)</h3>
            <div class="grid">
              <div class="field"><label>Date</label><input v-model="f.AlinacakTarih" type="date" class="p-inputtext" required /></div>
              <div class="field"><label>Time</label><input v-model="f.AlinacakSaat" type="time" class="p-inputtext" /></div>
              <label class="check"><Checkbox v-model="collectTime" binary :disabled="!canEdit" /> Time confirmed</label>
              <div class="field span2"><label>Place</label><InputText v-model="f.AlinacakYer" list="collect-places" /></div>
              <div class="field full"><label>Notes</label><Textarea v-model="f.AlinacakNotlar" rows="2" auto-resize /></div>
            </div>
          </div>
        </div>
        <datalist id="deliver-places"><option v-for="p in places.deliver" :key="p" :value="p" /></datalist>
        <datalist id="collect-places"><option v-for="p in places.collect" :key="p" :value="p" /></datalist>
      </section>

      <section class="card">
        <h2>Customer</h2>
        <CustomerPicker v-if="canEdit" :allow-create="auth.can('customers')" @select="pickCustomer" />
        <div class="grid mt">
          <div class="field"><label>Name *</label><InputText v-model="f.Name" /></div>
          <div class="field"><label>Surname *</label><InputText v-model="f.Surname" /></div>
          <div class="field"><label>Contact number</label><InputText v-model="f.ContactNumber" /></div>
          <div class="field"><label>Passport / ID</label><InputText v-model="f.PassportId" /></div>
          <div class="field"><label>Driving licence</label><InputText v-model="f.LicenseNo" /></div>
          <div class="field"><label>Place of birth</label><InputText v-model="f.PlaceofBirth" /></div>
          <div class="field"><label>Agency</label><Select v-model="f.Agency" :options="agencies" editable :disabled="!canEdit" /></div>
          <div class="field"><label>Company</label><Select v-model="f.Company" :options="companies" editable :disabled="!canEdit" /></div>
          <div class="field"><label>Company income</label><InputNumber v-model="f.Companyincome" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
          <div class="field"><label>Voucher no</label><InputText v-model="f.VoucherNo" /></div>
          <div class="field"><label>Room no</label><InputText v-model="f.RoomNo" /></div>
        </div>
        <p v-if="f.Customerid" class="muted small">Linked customer #{{ f.Customerid }} · <RouterLink :to="`/customers/${f.Customerid}`">open card</RouterLink></p>
      </section>

      <section class="card">
        <h2>Price ({{ sym }})</h2>
        <div class="price-table">
          <div class="ph"></div><div class="ph">Rate / day</div><div class="ph">Days</div><div class="ph">Total</div>
          <div class="pl">Low season <small>Nov–Mar</small></div>
          <InputNumber v-model="f.LowSeasonRate" :min-fraction-digits="2" :max-fraction-digits="2" /><InputNumber v-model="f.LowSeasonDays" :max-fraction-digits="1" /><div class="num">{{ fmtMoney(totals.LowSeasonTotal) }}</div>
          <div class="pl">Mid season <small>Apr–Jun</small></div>
          <InputNumber v-model="f.MidSeasonRate" :min-fraction-digits="2" :max-fraction-digits="2" /><InputNumber v-model="f.MidSeasonDays" :max-fraction-digits="1" /><div class="num">{{ fmtMoney(totals.MidSeasonTotal) }}</div>
          <div class="pl">High season <small>Jul–Oct</small></div>
          <InputNumber v-model="f.HighSeasonRate" :min-fraction-digits="2" :max-fraction-digits="2" /><InputNumber v-model="f.HighSeasonDays" :max-fraction-digits="1" /><div class="num">{{ fmtMoney(totals.HighSeasonTotal) }}</div>
          <div class="pl">Extension</div>
          <InputNumber v-model="f.ExtensionRate" :min-fraction-digits="2" :max-fraction-digits="2" /><InputNumber v-model="f.ExtensionDays" :max-fraction-digits="1" /><div class="num">{{ fmtMoney(totals.ExtensionTotal) }}</div>
          <div class="pl">Insurance</div>
          <InputNumber v-model="f.Dailyinsurance" :min-fraction-digits="2" :max-fraction-digits="2" /><div class="num muted">{{ totals.TotalDays }} days</div><div class="num">{{ fmtMoney(totals.Totalinsurance) }}</div>
        </div>
        <div class="row mt"><Button label="Recount days from dates" icon="pi pi-calendar" size="small" outlined :disabled="!canEdit" @click="calc(true)" /></div>
        <div class="grid mt">
          <div class="field"><label>Petrol</label><InputNumber v-model="f.Petrol" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
          <div class="field"><label>Extra</label><InputNumber v-model="f.Extra" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
          <div class="field"><label>Discount</label><InputNumber v-model="f.Discount" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
          <div class="field"><label>Commission %</label><InputNumber v-model="f.Commission" :max-fraction-digits="2" suffix=" %" /></div>
          <div class="field"><label>Less insurance / day</label><InputNumber v-model="f.Lessinsurance" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
          <div class="field"><label>Baby seat</label><Select v-model="f.BabySeat" :options="seatOptions" :disabled="!canEdit" /></div>
          <div class="field"><label>Booster seat</label><Select v-model="f.BoosterSeat" :options="seatOptions" :disabled="!canEdit" /></div>
          <div class="field"><label>Infant seat</label><Select v-model="f.infantSeat" :options="seatOptions" :disabled="!canEdit" /></div>
        </div>
      </section>

      <section class="card">
        <h2>Payments</h2>
        <div v-for="n in [1, 2, 3, 4] as const" :key="n" class="pay-row">
          <span class="muted">{{ n }}.</span>
          <Select v-model="(f as any)[`PaymentMethod${n}`]" :options="payMethods" placeholder="Method" :disabled="!canEdit" />
          <InputNumber v-model="(f as any)[`PaidAmount${n}`]" :min-fraction-digits="2" :max-fraction-digits="2" placeholder="Amount" />
          <Select v-model="(f as any)[`PaidNote${n}`]" :options="payNotes" placeholder="Note" :disabled="!canEdit" />
        </div>
      </section>

      <section class="card">
        <h2>Taxi / flight</h2>
        <div class="grid">
          <div class="field"><label>Flight number</label><InputText v-model="f.FlightNumber" /></div>
          <div class="field"><label>Flight time</label><input v-model="f.FlightTime" type="time" class="p-inputtext" /></div>
          <label class="check"><Checkbox v-model="flightTime" binary :disabled="!canEdit" /> Flight time known</label>
          <div class="field"><label>Return flight time</label><input v-model="f.DtFlightTime2" type="time" class="p-inputtext" /></div>
          <label class="check"><Checkbox v-model="flightTime2" binary :disabled="!canEdit" /> Return time known</label>
        </div>
        <div class="two-col mt">
          <div class="sub">
            <h3>Pick up (arrival)</h3>
            <div class="grid">
              <div class="field"><label>From</label><InputText v-model="f.TaxiDeliverFrom" list="deliver-places" /></div>
              <div class="field"><label>To</label><InputText v-model="f.TaxiDeliverTo" list="deliver-places" /></div>
              <div class="field"><label>Date</label><input v-model="f.TaxiDateDeliver" type="date" class="p-inputtext" /></div>
              <div class="field"><label>Time</label><input v-model="f.TaxiTimeDeliver" type="time" class="p-inputtext" /></div>
              <label class="check"><Checkbox v-model="taxiTimeDeliver" binary :disabled="!canEdit" /> Time confirmed</label>
              <div class="field"><label>Pax</label><InputNumber v-model="f.PaxsPickUp" /></div>
              <div class="field"><label>Cases</label><InputNumber v-model="f.Cases" /></div>
              <div class="field"><label>Price</label><InputNumber v-model="f.TaxiPickUp" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
            </div>
          </div>
          <div class="sub">
            <h3>Drop off (departure)</h3>
            <div class="grid">
              <div class="field"><label>From</label><InputText v-model="f.TaxiCollectFrom" list="collect-places" /></div>
              <div class="field"><label>To</label><InputText v-model="f.TaxiCollectTo" list="collect-places" /></div>
              <div class="field"><label>Date</label><input v-model="f.TaxiDateCollect" type="date" class="p-inputtext" /></div>
              <div class="field"><label>Time</label><input v-model="f.TaxiTimeCollect" type="time" class="p-inputtext" /></div>
              <label class="check"><Checkbox v-model="taxiTimeCollect" binary :disabled="!canEdit" /> Time confirmed</label>
              <div class="field"><label>Pax</label><InputNumber v-model="f.PaxsDropOff" /></div>
              <div class="field"><label>Price</label><InputNumber v-model="f.TaxiDropOff" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
            </div>
          </div>
        </div>
      </section>

      <section class="card">
        <h2>Notes</h2>
        <Textarea v-model="f.Notes" rows="3" auto-resize class="w-full" />
      </section>
    </fieldset>

    <div class="sticky-actions summary">
      <div class="sum">
        <span>Days <b>{{ totals.TotalDays }}</b></span>
        <span>Total <b>{{ fmtMoney(totals.GeneralTotal, f.currency) }}</b></span>
        <span>Commission <b>{{ fmtMoney(totals.TotalComission, f.currency) }}</b></span>
        <span :class="{ due: totals.OutstandingBalance > 0 }">Balance <b>{{ fmtMoney(totals.OutstandingBalance, f.currency) }}</b></span>
      </div>
      <template v-if="canEdit">
        <Button v-if="id" label="Delete" icon="pi pi-trash" severity="danger" outlined @click="remove" />
        <Button :label="id ? 'Save changes' : 'Save'" icon="pi pi-check" :loading="saving" @click="save" />
      </template>
    </div>
    <p v-if="id" class="muted small">Delivery {{ fmtDate(f.BirakilacakTarih) }} {{ f.BirakilacakSaat }} → Collection {{ fmtDate(f.AlinacakTarih) }} {{ f.AlinacakSaat }}</p>
  </div>
</template>

<style scoped>
.plain { border: 0; padding: 0; margin: 0; min-width: 0; }
.two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; margin-top: 10px; }
.sub { border: 1px dashed var(--app-border); border-radius: 8px; padding: 10px; }
.sub h3 { font-size: 0.9rem; margin: 0 0 8px; }
.price-table { display: grid; grid-template-columns: minmax(110px, 1.2fr) 1fr 0.7fr 1fr; gap: 6px 10px; align-items: center; }
.price-table :deep(.p-inputnumber), .price-table :deep(input) { width: 100%; min-width: 0; }
.ph { font-size: 12px; font-weight: 600; color: var(--app-muted); }
.pl small { color: var(--app-muted); display: block; font-size: 11px; }
.pay-row { display: grid; grid-template-columns: 20px 1fr 1fr 1fr; gap: 8px; align-items: center; margin-bottom: 6px; }
.pay-row :deep(.p-inputnumber input) { width: 100%; }
.summary { justify-content: space-between; align-items: center; margin: 0; border-radius: 10px; }
.sum { display: flex; gap: 16px; flex-wrap: wrap; }
.due b { color: #dc2626; }
.mt { margin-top: 10px; }
.mb { margin-bottom: 10px; }
.ml { margin-left: 8px; vertical-align: middle; }
.small { font-size: 12px; }
.w-full { width: 100%; }
@media (max-width: 760px) {
  .two-col { grid-template-columns: 1fr; }
  .price-table { grid-template-columns: 1fr 1fr 0.8fr 1fr; font-size: 12px; }
  .pay-row { grid-template-columns: 16px 1fr 1fr; }
  .pay-row > :last-child { grid-column: 2 / -1; }
}
</style>
