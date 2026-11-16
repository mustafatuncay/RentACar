<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import CustomerPicker from '../components/CustomerPicker.vue';
import { api } from '../lib/api';
import { CURRENCIES, fmtTime, toDateInput, today } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const route = useRoute();
const router = useRouter();
const ui = useUi();
const auth = useAuth();
const id = computed(() => (route.params.id === 'new' ? null : Number(route.params.id)));
const canEdit = computed(() => auth.can('transfers'));
const saving = ref(false);
const agencies = ref<string[]>([]);
const cars = ref<any[]>([]);
const sugg = ref<{ drivers: string[]; places: string[]; paidTo: string[] }>({ drivers: [], places: [], paidTo: [] });
const seats = ['0', '1', '2', '3', '4'];

const blank = () => ({
  Customerid: 0, Name: '', Surname: '', ContactNumber: '', PassportId: '', LicenseNo: '', PlaceofBirth: '',
  CheckedArrival: 'Y', ArrivalDate: today(), ArrivalTime: '00:00', ArrivalTimeChecked: 'N', ArrivalFlightNo: '',
  ArrivalCollectFrom: '', ArrivalDestination: '', ArrivalPax: 0, ArrivalCase: 0, ArrivalBabySeat: '0', ArrivalBoosterSeat: '0', Arrivalinfant: '0',
  ArrivalPrice: 0, ArrivalPaid: 'N', ArrivalPaidTo: '', ArrivalNotes: '',
  CheckedDeparture: 'N', DepartureDate: today(), DepartureTime: '00:00', DepartureTimeChecked: 'N',
  DepartureCollectFrom: '', DepartureDestination: '', DeparturePax: 0, DepartureCase: 0, DepartureBabySeat: '0', DepartureBoosterSeat: '0', Departureinfant: '0',
  DeparturePrice: 0, DeparturePaid: 'N', PaidTo: '', DepartureNotes: '',
  Driver: '', Driver2: '', AgencyName: '', Currency: 'STERLIN', Carid: 0, RegNo: '',
});
type Form = ReturnType<typeof blank>;
const f = reactive<Form>(blank());

const yn = (k: keyof Form) => computed({ get: () => f[k] === 'Y', set: (v: boolean) => ((f as any)[k] = v ? 'Y' : 'N') });
const arr = yn('CheckedArrival');
const dep = yn('CheckedDeparture');
const arrTime = yn('ArrivalTimeChecked');
const depTime = yn('DepartureTimeChecked');
const arrPaid = yn('ArrivalPaid');
const depPaid = yn('DeparturePaid');

function fill(r: any) {
  const b = blank();
  for (const k of Object.keys(b) as (keyof Form)[]) {
    const v = r[k];
    if (v === undefined || v === null) continue;
    if (typeof b[k] === 'number') (f as any)[k] = Number(v);
    else if (k.endsWith('Date')) (f as any)[k] = toDateInput(v);
    else if (k.endsWith('Time')) (f as any)[k] = fmtTime(v) || '00:00';
    else (f as any)[k] = String(v);
  }
}

async function load() {
  try {
    const [a, c, s] = await Promise.all([api.get('/api/agencies'), api.get('/api/cars'), api.get('/api/transfers/suggestions')]);
    agencies.value = ['', ...a.map((x: any) => x.name)];
    cars.value = [{ id: 0, label: '— none —' }, ...c.map((x: any) => ({ id: x.id, label: `${x.Model} ${x.RegNo}` }))];
    sugg.value = s;
    if (id.value) {
      fill(await api.get(`/api/transfers/${id.value}`));
    } else if (route.query.reservationId) {
      // Prefill from the reservation (UntReservation2.ImgTransfersClick)
      const r = await api.get(`/api/reservations/${route.query.reservationId}`);
      Object.assign(f, {
        Customerid: Number(r.Customerid ?? 0), Name: r.Name ?? '', Surname: r.Surname ?? '', ContactNumber: r.ContactNumber ?? '',
        PassportId: r.PassportId ?? '', LicenseNo: r.LicenseNo ?? '', PlaceofBirth: r.PlaceofBirth ?? '',
        Carid: Number(r.Carid ?? 0), RegNo: String(r.id), AgencyName: r.Agency ?? '', Currency: r.currency || 'STERLIN',
        ArrivalDate: toDateInput(r.TaxiDateDeliver) || toDateInput(r.BirakilacakTarih), ArrivalTime: fmtTime(r.TaxiTimeDeliver) || '00:00',
        ArrivalPax: Number(r.PaxsPickUp ?? 0), ArrivalCase: Number(r.Cases ?? 0),
        ArrivalBabySeat: r.BabySeat || '0', ArrivalBoosterSeat: r.BoosterSeat || '0', Arrivalinfant: r.infantSeat || '0',
        ArrivalPrice: Number(r.TaxiPickUp ?? 0), ArrivalFlightNo: r.FlightNumber ?? '',
        ArrivalCollectFrom: r.TaxiDeliverFrom ?? '', ArrivalDestination: r.birakilacakYer ?? '',
        CheckedDeparture: r.TaxiCollectFrom ? 'Y' : 'N',
        DepartureDate: toDateInput(r.TaxiDateCollect) || toDateInput(r.AlinacakTarih), DepartureTime: fmtTime(r.TaxiTimeCollect) || '00:00',
        DeparturePrice: Number(r.TaxiDropOff ?? 0), DeparturePax: Number(r.PaxsDropOff ?? 0),
        DepartureCollectFrom: r.AlinacakYer ?? '', DepartureDestination: r.TaxiCollectTo ?? '',
      });
    }
  } catch (e) {
    ui.error(e);
  }
}

function pickCustomer(c: any) {
  Object.assign(f, {
    Customerid: c.id, Name: c.Name ?? '', Surname: c.Surname ?? '', ContactNumber: c.TelNo || c.LocalNumber || '',
    PassportId: c.PassportId ?? '', LicenseNo: c.LicenseNo ?? '', PlaceofBirth: c.PlaceofBirth ?? '',
  });
  if (c.BlackList === 'Y') ui.toast.add({ severity: 'warn', summary: 'Black list', detail: 'This customer is on the black list', life: 6000 });
}

async function save() {
  saving.value = true;
  try {
    const res = await ui.saveWithBlacklist((confirmBlacklist) =>
      id.value ? api.put(`/api/transfers/${id.value}`, { ...f, confirmBlacklist }) : api.post('/api/transfers', { ...f, confirmBlacklist }),
    );
    if (!res) return;
    ui.ok('Transfer saved');
    if (!id.value) router.replace(`/transfers/${res.id}`);
  } catch (e) {
    ui.error(e);
  } finally {
    saving.value = false;
  }
}
async function remove() {
  if (!(await ui.ask('Do you want to delete this transfer?', 'Delete', true))) return;
  try {
    await api.del(`/api/transfers/${id.value}`);
    router.replace('/transfers');
  } catch (e) {
    ui.error(e);
  }
}
onMounted(load);
</script>

<template>
  <div class="page">
    <div class="page-header">
      <Button icon="pi pi-arrow-left" text rounded aria-label="Back" @click="router.back()" />
      <h1>{{ id ? `Transfer #${id}` : 'New transfer' }}</h1>
      <Button v-if="f.RegNo" :label="`Reservation #${f.RegNo}`" icon="pi pi-book" outlined @click="router.push(`/reservations/${f.RegNo}`)" />
    </div>
    <datalist id="t-places"><option v-for="p in sugg.places" :key="p" :value="p" /></datalist>
    <datalist id="t-drivers"><option v-for="p in sugg.drivers" :key="p" :value="p" /></datalist>
    <datalist id="t-paid"><option v-for="p in sugg.paidTo" :key="p" :value="p" /></datalist>

    <fieldset :disabled="!canEdit" class="plain">
      <section class="card">
        <h2>Customer</h2>
        <CustomerPicker v-if="canEdit" :allow-create="auth.can('customers')" @select="pickCustomer" />
        <div class="grid mt">
          <div class="field"><label>Name *</label><InputText v-model="f.Name" /></div>
          <div class="field"><label>Surname *</label><InputText v-model="f.Surname" /></div>
          <div class="field"><label>Contact number</label><InputText v-model="f.ContactNumber" /></div>
          <div class="field"><label>Passport</label><InputText v-model="f.PassportId" /></div>
          <div class="field"><label>Agency</label><Select v-model="f.AgencyName" :options="agencies" editable :disabled="!canEdit" /></div>
          <div class="field"><label>Currency</label><Select v-model="f.Currency" :options="[...CURRENCIES]" :disabled="!canEdit" /></div>
          <div class="field"><label>Driver</label><InputText v-model="f.Driver" list="t-drivers" /></div>
          <div class="field"><label>Driver 2</label><InputText v-model="f.Driver2" list="t-drivers" /></div>
          <div class="field span2"><label>Car</label><Select v-model="f.Carid" :options="cars" option-label="label" option-value="id" filter :disabled="!canEdit" /></div>
        </div>
      </section>

      <div class="two-col">
        <section class="card" :class="{ off: !arr }">
          <h2><label class="check"><Checkbox v-model="arr" binary :disabled="!canEdit" /> Arrival (from airport)</label></h2>
          <div class="grid">
            <div class="field"><label>Date</label><input v-model="f.ArrivalDate" type="date" class="p-inputtext" /></div>
            <div class="field"><label>Time</label><input v-model="f.ArrivalTime" type="time" class="p-inputtext" /></div>
            <label class="check"><Checkbox v-model="arrTime" binary :disabled="!canEdit" /> Time confirmed</label>
            <div class="field"><label>Flight no</label><InputText v-model="f.ArrivalFlightNo" /></div>
            <div class="field"><label>Collect from</label><InputText v-model="f.ArrivalCollectFrom" list="t-places" /></div>
            <div class="field"><label>Destination</label><InputText v-model="f.ArrivalDestination" list="t-places" /></div>
            <div class="field"><label>Pax</label><InputNumber v-model="f.ArrivalPax" /></div>
            <div class="field"><label>Cases</label><InputNumber v-model="f.ArrivalCase" /></div>
            <div class="field"><label>Baby seat</label><Select v-model="f.ArrivalBabySeat" :options="seats" :disabled="!canEdit" /></div>
            <div class="field"><label>Booster seat</label><Select v-model="f.ArrivalBoosterSeat" :options="seats" :disabled="!canEdit" /></div>
            <div class="field"><label>Infant seat</label><Select v-model="f.Arrivalinfant" :options="seats" :disabled="!canEdit" /></div>
            <div class="field"><label>Price</label><InputNumber v-model="f.ArrivalPrice" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
            <label class="check"><Checkbox v-model="arrPaid" binary :disabled="!canEdit" /> Paid</label>
            <div class="field"><label>Paid to</label><InputText v-model="f.ArrivalPaidTo" list="t-paid" /></div>
            <div class="field full"><label>Notes</label><Textarea v-model="f.ArrivalNotes" rows="2" auto-resize /></div>
          </div>
        </section>
        <section class="card" :class="{ off: !dep }">
          <h2><label class="check"><Checkbox v-model="dep" binary :disabled="!canEdit" /> Departure (to airport)</label></h2>
          <div class="grid">
            <div class="field"><label>Date</label><input v-model="f.DepartureDate" type="date" class="p-inputtext" /></div>
            <div class="field"><label>Time</label><input v-model="f.DepartureTime" type="time" class="p-inputtext" /></div>
            <label class="check"><Checkbox v-model="depTime" binary :disabled="!canEdit" /> Time confirmed</label>
            <div class="field"><label>Collect from</label><InputText v-model="f.DepartureCollectFrom" list="t-places" /></div>
            <div class="field"><label>Destination</label><InputText v-model="f.DepartureDestination" list="t-places" /></div>
            <div class="field"><label>Pax</label><InputNumber v-model="f.DeparturePax" /></div>
            <div class="field"><label>Cases</label><InputNumber v-model="f.DepartureCase" /></div>
            <div class="field"><label>Baby seat</label><Select v-model="f.DepartureBabySeat" :options="seats" :disabled="!canEdit" /></div>
            <div class="field"><label>Booster seat</label><Select v-model="f.DepartureBoosterSeat" :options="seats" :disabled="!canEdit" /></div>
            <div class="field"><label>Infant seat</label><Select v-model="f.Departureinfant" :options="seats" :disabled="!canEdit" /></div>
            <div class="field"><label>Price</label><InputNumber v-model="f.DeparturePrice" :min-fraction-digits="2" :max-fraction-digits="2" /></div>
            <label class="check"><Checkbox v-model="depPaid" binary :disabled="!canEdit" /> Paid</label>
            <div class="field"><label>Paid to</label><InputText v-model="f.PaidTo" list="t-paid" /></div>
            <div class="field full"><label>Notes</label><Textarea v-model="f.DepartureNotes" rows="2" auto-resize /></div>
          </div>
        </section>
      </div>
    </fieldset>

    <div v-if="canEdit" class="actions">
      <Button v-if="id" label="Delete" icon="pi pi-trash" severity="danger" outlined @click="remove" />
      <Button label="Save" icon="pi pi-check" :loading="saving" @click="save" />
    </div>
  </div>
</template>

<style scoped>
.plain { border: 0; padding: 0; margin: 0; min-width: 0; }
.two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
.off { opacity: 0.55; }
.mt { margin-top: 10px; }
@media (max-width: 900px) { .two-col { grid-template-columns: 1fr; } }
</style>
