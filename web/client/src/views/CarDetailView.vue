<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import SubRecords, { type FieldDef } from '../components/SubRecords.vue';
import { api } from '../lib/api';
import { CAR_GROUPS, toDateInput } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const route = useRoute();
const router = useRouter();
const ui = useUi();
const auth = useAuth();
const id = computed(() => (route.params.id === 'new' ? null : Number(route.params.id)));
const canEdit = computed(() => auth.can('cars'));
const tab = ref('details');
const saving = ref(false);
const models = ref<string[]>([]);
const f = reactive({ Model: '', RegNo: '', Grup: 'Group 1', Type: '', SiraNo: 0, Sold: 0, Color: '', FontColor: '', MuayeneTarihi: '', Notes: '' });
const sold = computed({ get: () => Number(f.Sold) === 1, set: (v: boolean) => (f.Sold = v ? 1 : 0) });

async function load() {
  try {
    models.value = await api.get('/api/cars/models');
    if (!id.value) return;
    const c = await api.get(`/api/cars/${id.value}`);
    Object.assign(f, {
      Model: c.Model ?? '', RegNo: c.RegNo ?? '', Grup: c.Grup || 'Group 1', Type: c.Type ?? '', SiraNo: Number(c.SiraNo ?? 0),
      Sold: Number(c.Sold ?? 0), Color: c.Color ?? '', FontColor: c.FontColor ?? '', MuayeneTarihi: toDateInput(c.MuayeneTarihi), Notes: c.Notes ?? '',
    });
  } catch (e) {
    ui.error(e);
  }
}
async function save() {
  saving.value = true;
  try {
    if (id.value) {
      await api.put(`/api/cars/${id.value}`, f);
      ui.ok('Car updated');
    } else {
      const r = await api.post('/api/cars', f);
      ui.ok('Car saved');
      router.replace(`/cars/${r.id}`);
    }
  } catch (e) {
    ui.error(e);
  } finally {
    saving.value = false;
  }
}
async function remove() {
  if (!(await ui.ask('Do you want to delete this car?', 'Delete', true))) return;
  try {
    await api.del(`/api/cars/${id.value}`);
    ui.ok('Car deleted');
    router.replace('/cars');
  } catch (e) {
    ui.error(e);
  }
}

const expenseFields: FieldDef[] = [
  { key: 'ExpenseDate', label: 'Date', type: 'date' },
  { key: 'expense', label: 'Expense', type: 'text' },
  { key: 'price', label: 'TL', type: 'money' },
  { key: 'priceSterlin', label: 'Sterlin', type: 'money' },
  { key: 'priceEuro', label: 'Euro', type: 'money' },
  { key: 'ServiceKm', label: 'Service km', type: 'number' },
  { key: 'NextServiceKm', label: 'Next service km', type: 'number' },
  { key: 'Notes', label: 'Notes', type: 'memo' },
];
const insuranceFields: FieldDef[] = [
  { key: 'company', label: 'Company', type: 'text' },
  { key: 'startdate', label: 'Start', type: 'date' },
  { key: 'enddate', label: 'End', type: 'date' },
  { key: 'paymentdate', label: 'Payment date', type: 'date' },
  { key: 'thirdpartyprice', label: 'Third party TL', type: 'money' },
  { key: 'kaskoprice', label: 'Kasko TL', type: 'money' },
  { key: 'thirdpartypriceSterlin', label: 'Third party £', type: 'money' },
  { key: 'kaskopriceSterlin', label: 'Kasko £', type: 'money' },
  { key: 'thirdpartypriceEuro', label: 'Third party €', type: 'money' },
  { key: 'kaskopriceEuro', label: 'Kasko €', type: 'money' },
  { key: 'Notes', label: 'Notes', type: 'memo' },
];
const seyruseferFields: FieldDef[] = [
  { key: 'startdate', label: 'Start', type: 'date' },
  { key: 'enddate', label: 'End', type: 'date' },
  { key: 'odemetarihi', label: 'Payment date', type: 'date' },
  { key: 'price', label: 'TL', type: 'money' },
  { key: 'PriceSterlin', label: 'Sterlin', type: 'money' },
  { key: 'PriceEuro', label: 'Euro', type: 'money' },
  { key: 'Notes', label: 'Notes', type: 'memo' },
];
onMounted(load);
</script>

<template>
  <div class="page">
    <div class="page-header">
      <Button icon="pi pi-arrow-left" text rounded aria-label="Back" @click="router.push('/cars')" />
      <h1>{{ id ? `${f.Model} ${f.RegNo}` : 'New car' }} <Tag v-if="sold" value="Sold" severity="secondary" /></h1>
    </div>
    <Tabs v-model:value="tab">
      <TabList>
        <Tab value="details">Details</Tab>
        <Tab value="expenses" :disabled="!id">Expenses / service</Tab>
        <Tab value="insurance" :disabled="!id">Insurance</Tab>
        <Tab value="seyrusefer" :disabled="!id">Seyrüsefer (road tax)</Tab>
      </TabList>
      <TabPanels>
        <TabPanel value="details">
          <fieldset :disabled="!canEdit" class="plain">
            <div class="grid">
              <div class="field"><label>Model *</label><InputText v-model="f.Model" list="models" /></div>
              <div class="field"><label>Reg. no *</label><InputText v-model="f.RegNo" /></div>
              <div class="field"><label>Group</label><Select v-model="f.Grup" :options="CAR_GROUPS" :disabled="!canEdit" /></div>
              <div class="field"><label>Type</label><InputText v-model="f.Type" placeholder="Manual / Automatic" /></div>
              <div class="field"><label>Order in time table</label><InputNumber v-model="f.SiraNo" :min="0" /></div>
              <div class="field"><label>Inspection (muayene)</label><input v-model="f.MuayeneTarihi" type="date" class="p-inputtext" /></div>
              <label class="check"><Checkbox v-model="sold" binary :disabled="!canEdit" /> Sold (hide from time table)</label>
              <div class="field full"><label>Notes</label><Textarea v-model="f.Notes" rows="3" auto-resize /></div>
            </div>
            <datalist id="models"><option v-for="m in models" :key="m" :value="m" /></datalist>
          </fieldset>
          <div v-if="canEdit" class="actions">
            <Button v-if="id" label="Delete" icon="pi pi-trash" severity="danger" outlined @click="remove" />
            <Button label="Save" icon="pi pi-check" :loading="saving" @click="save" />
          </div>
        </TabPanel>
        <TabPanel value="expenses">
          <SubRecords v-if="id" :car-id="id" kind="expenses" title="Expense" :fields="expenseFields" :can-edit="canEdit"
            :columns="['ExpenseDate', 'expense', 'price', 'priceSterlin', 'priceEuro', 'ServiceKm', 'NextServiceKm']" />
        </TabPanel>
        <TabPanel value="insurance">
          <SubRecords v-if="id" :car-id="id" kind="insurance" title="Insurance" :fields="insuranceFields" :can-edit="canEdit"
            :columns="['company', 'startdate', 'enddate', 'paymentdate', 'totalprice', 'totalpriceSterlin', 'totalpriceEuro']" />
        </TabPanel>
        <TabPanel value="seyrusefer">
          <SubRecords v-if="id" :car-id="id" kind="seyrusefer" title="Seyrüsefer" :fields="seyruseferFields" :can-edit="canEdit"
            :columns="['startdate', 'enddate', 'odemetarihi', 'price', 'PriceSterlin', 'PriceEuro']" />
        </TabPanel>
      </TabPanels>
    </Tabs>
  </div>
</template>

<style scoped>
.plain { border: 0; padding: 0; margin: 0; min-width: 0; }
</style>
