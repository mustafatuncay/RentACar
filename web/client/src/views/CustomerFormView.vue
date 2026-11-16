<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { api } from '../lib/api';
import { fmtDate, fmtMoney, toDateInput } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const route = useRoute();
const router = useRouter();
const ui = useUi();
const auth = useAuth();
const id = computed(() => (route.params.id === 'new' ? null : Number(route.params.id)));
const canEdit = computed(() => auth.can('customers'));
const saving = ref(false);
const history = ref<any[]>([]);
const titles = ['', 'Mr', 'Mrs', 'Miss'];

const DATE_KEYS = ['BirthDate', 'Expire1', 'BirthDate2', 'Expire2', 'BirthDate3', 'Expire3'];
const blank = () => ({
  Name: '', Surname: '', BayBayan1: '', PassportId: '', LicenseNo: '', BirthDate: '', CheckedBirthDate: 'N', Expire1: '', PlaceofBirth: '',
  Email: '', TelNo: '', CyprusMobile: '', LocalNumber: '', Address: '', LocalAddress: '', CustNumber: '', BlackList: 'N', BlackNote: '',
  Name2: '', Surname2: '', BayBayan2: '', PassportId2: '', LicenseNo2: '', BirthDate2: '', CheckedBirthDate2: 'N', Expire2: '', Email2: '',
  Name3: '', Surname3: '', BayBayan3: '', PassportId3: '', LicenseNo3: '', BirthDate3: '', CheckedBirthDate3: 'N', Expire3: '', Email3: '',
});
const f = reactive(blank());
const black = computed({ get: () => f.BlackList === 'Y', set: (v: boolean) => (f.BlackList = v ? 'Y' : 'N') });

async function load() {
  if (!id.value) return;
  try {
    const c = await api.get(`/api/customers/${id.value}`);
    for (const k of Object.keys(f) as (keyof typeof f)[]) {
      const v = c[k];
      (f as any)[k] = DATE_KEYS.includes(k) ? toDateInput(v) : v === null || v === undefined ? (k.startsWith('Checked') ? 'N' : '') : String(v);
    }
    if (!['', 'Mr', 'Mrs', 'Miss'].includes(f.BayBayan1)) f.BayBayan1 = '';
    if (!['', 'Mr', 'Mrs', 'Miss'].includes(f.BayBayan2)) f.BayBayan2 = '';
    if (!['', 'Mr', 'Mrs', 'Miss'].includes(f.BayBayan3)) f.BayBayan3 = '';
    history.value = await api.get(`/api/customers/${id.value}/history`);
  } catch (e) {
    ui.error(e);
  }
}
async function save() {
  saving.value = true;
  try {
    if (id.value) {
      await api.put(`/api/customers/${id.value}`, f);
      ui.ok('Customer updated');
    } else {
      const r = await api.post('/api/customers', f);
      ui.ok('Customer saved');
      router.replace(`/customers/${r.id}`);
    }
  } catch (e) {
    ui.error(e);
  } finally {
    saving.value = false;
  }
}
async function remove() {
  if (!(await ui.ask('Do you want to delete this customer?', 'Delete', true))) return;
  try {
    await api.del(`/api/customers/${id.value}`);
    ui.ok('Customer deleted');
    router.replace('/customers');
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
      <h1>{{ id ? `${f.Name} ${f.Surname}` : 'New customer' }} <Tag v-if="black" value="BLACK LIST" severity="danger" /></h1>
      <Button v-if="id && auth.can('timetable')" label="New reservation" icon="pi pi-plus" outlined @click="router.push('/reservations/new')" />
    </div>

    <fieldset :disabled="!canEdit" class="plain">
      <section class="card">
        <h2>Main driver</h2>
        <div class="grid">
          <div class="field"><label>Title</label><Select v-model="f.BayBayan1" :options="titles" :disabled="!canEdit" /></div>
          <div class="field"><label>Name *</label><InputText v-model="f.Name" /></div>
          <div class="field"><label>Surname *</label><InputText v-model="f.Surname" /></div>
          <div class="field"><label>Customer no</label><InputText v-model="f.CustNumber" /></div>
          <div class="field"><label>Passport / ID</label><InputText v-model="f.PassportId" /></div>
          <div class="field"><label>Driving licence</label><InputText v-model="f.LicenseNo" /></div>
          <div class="field"><label>Licence expiry</label><input v-model="f.Expire1" type="date" class="p-inputtext" /></div>
          <div class="field"><label>Birth date</label><input v-model="f.BirthDate" type="date" class="p-inputtext" /></div>
          <div class="field"><label>Place of birth</label><InputText v-model="f.PlaceofBirth" /></div>
          <div class="field"><label>E-mail</label><InputText v-model="f.Email" type="email" /></div>
          <div class="field"><label>Phone</label><InputText v-model="f.TelNo" type="tel" /></div>
          <div class="field"><label>Cyprus mobile</label><InputText v-model="f.CyprusMobile" type="tel" /></div>
          <div class="field"><label>Local number</label><InputText v-model="f.LocalNumber" type="tel" /></div>
          <div class="field span2"><label>Address</label><Textarea v-model="f.Address" rows="2" auto-resize /></div>
          <div class="field span2"><label>Local address</label><Textarea v-model="f.LocalAddress" rows="2" auto-resize /></div>
        </div>
      </section>

      <section v-for="n in [2, 3]" :key="n" class="card">
        <h2>Driver {{ n }}</h2>
        <div class="grid">
          <div class="field"><label>Title</label><Select v-model="(f as any)[`BayBayan${n}`]" :options="titles" :disabled="!canEdit" /></div>
          <div class="field"><label>Name</label><InputText v-model="(f as any)[`Name${n}`]" /></div>
          <div class="field"><label>Surname</label><InputText v-model="(f as any)[`Surname${n}`]" /></div>
          <div class="field"><label>Passport / ID</label><InputText v-model="(f as any)[`PassportId${n}`]" /></div>
          <div class="field"><label>Driving licence</label><InputText v-model="(f as any)[`LicenseNo${n}`]" /></div>
          <div class="field"><label>Licence expiry</label><input v-model="(f as any)[`Expire${n}`]" type="date" class="p-inputtext" /></div>
          <div class="field"><label>Birth date</label><input v-model="(f as any)[`BirthDate${n}`]" type="date" class="p-inputtext" /></div>
          <div class="field"><label>E-mail</label><InputText v-model="(f as any)[`Email${n}`]" type="email" /></div>
        </div>
      </section>

      <section class="card" :class="{ danger: black }">
        <h2>Black list</h2>
        <label class="check"><Checkbox v-model="black" binary :disabled="!canEdit" /> This customer is on the black list</label>
        <div class="field mt"><label>Reason</label><Textarea v-model="f.BlackNote" rows="2" auto-resize /></div>
      </section>
    </fieldset>

    <div v-if="canEdit" class="actions">
      <Button v-if="id" label="Delete" icon="pi pi-trash" severity="danger" outlined @click="remove" />
      <Button label="Save" icon="pi pi-check" :loading="saving" @click="save" />
    </div>

    <section v-if="id" class="card mt">
      <h2>Rental history</h2>
      <DataTable :value="history" size="small" row-hover :row-class="() => 'clickable-row'" @row-click="(e: any) => router.push(`/reservations/${e.data.id}`)">
        <template #empty>No reservations.</template>
        <Column field="id" header="#" />
        <Column header="Deliver"><template #body="{ data }">{{ fmtDate(data.BirakilacakTarih) }}</template></Column>
        <Column header="Collect"><template #body="{ data }">{{ fmtDate(data.AlinacakTarih) }}</template></Column>
        <Column header="Car"><template #body="{ data }">{{ data.CarModel }} {{ data.CarRegNo }}</template></Column>
        <Column header="Total" class="num"><template #body="{ data }">{{ fmtMoney(data.GeneralTotal, data.Currency ?? data.currency) }}</template></Column>
        <Column header="Balance" class="num"><template #body="{ data }">{{ fmtMoney(data.OutstandingBalance, data.Currency ?? data.currency) }}</template></Column>
      </DataTable>
    </section>
  </div>
</template>

<style scoped>
.plain { border: 0; padding: 0; margin: 0; min-width: 0; }
.danger { border-color: #ef4444; }
.mt { margin-top: 10px; }
</style>
