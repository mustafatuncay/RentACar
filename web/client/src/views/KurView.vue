<script setup lang="ts">
import { onMounted, reactive, ref } from 'vue';
import { api, qs } from '../lib/api';
import { addDays, fmtDate, today } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

/** Exchange rates (UntKur + the "Döviz" button of the main menu). */
const ui = useUi();
const auth = useAuth();
const rows = ref<any[]>([]);
const from = ref(addDays(today(), -30));
const to = ref(today());
const fetching = ref(false);
const f = reactive({ tarih: today(), parabirimi: 'STERLIN', alis: null as number | null, satis: null as number | null });

async function load() {
  try { rows.value = await api.get(`/api/kur${qs({ from: from.value, to: to.value })}`); } catch (e) { ui.error(e); }
}
async function save() {
  try {
    await api.post('/api/kur', f);
    ui.ok('Rate saved');
    load();
  } catch (e) { ui.error(e); }
}
async function fetchBank() {
  fetching.value = true;
  try {
    const r = await api.post('/api/kur/fetch');
    ui.ok(`Rates of ${r.bankDate || 'today'} saved`);
    load();
  } catch (e) { ui.error(e); } finally { fetching.value = false; }
}
function edit(r: any) {
  Object.assign(f, { tarih: r.tarih.slice(0, 10), parabirimi: r.parabirimi, alis: Number(r.alis), satis: Number(r.satis) });
}
async function remove(r: any) {
  if (!(await ui.ask('Delete this rate?', 'Delete', true))) return;
  try { await api.del(`/api/kur/${r.id}`); load(); } catch (e) { ui.error(e); }
}
onMounted(load);
</script>

<template>
  <div class="page narrow">
    <div class="page-header">
      <h1>Exchange rates</h1>
      <Button label="Get today's rates from central bank" icon="pi pi-download" outlined :loading="fetching" @click="fetchBank" />
    </div>
    <div class="card">
      <h2>Enter manually</h2>
      <form class="toolbar" @submit.prevent="save">
        <div class="field"><label>Date</label><input v-model="f.tarih" type="date" class="p-inputtext" required /></div>
        <div class="field"><label>Currency</label><Select v-model="f.parabirimi" :options="['STERLIN', 'EURO', 'DOLLAR']" /></div>
        <div class="field"><label>Buying</label><InputNumber v-model="f.alis" :min-fraction-digits="2" :max-fraction-digits="5" /></div>
        <div class="field"><label>Selling</label><InputNumber v-model="f.satis" :min-fraction-digits="2" :max-fraction-digits="5" /></div>
        <Button type="submit" label="Save" icon="pi pi-check" :disabled="!f.alis || !f.satis" />
      </form>
    </div>
    <div class="card">
      <form class="toolbar" @submit.prevent="load">
        <div class="field"><label>From</label><input v-model="from" type="date" class="p-inputtext" /></div>
        <div class="field"><label>To</label><input v-model="to" type="date" class="p-inputtext" /></div>
        <Button type="submit" icon="pi pi-search" label="List" />
      </form>
      <DataTable :value="rows" size="small" striped-rows paginator :rows="30" row-hover :row-class="() => 'clickable-row'" @row-click="(e: any) => edit(e.data)">
        <template #empty>No rates.</template>
        <Column header="Date"><template #body="{ data }">{{ fmtDate(data.tarih) }}</template></Column>
        <Column field="parabirimi" header="Currency" />
        <Column header="Buying" class="num"><template #body="{ data }">{{ Number(data.alis).toFixed(5) }}</template></Column>
        <Column header="Selling" class="num"><template #body="{ data }">{{ Number(data.satis).toFixed(5) }}</template></Column>
        <Column v-if="auth.can('admin')" header="" style="width: 60px">
          <template #body="{ data }"><Button icon="pi pi-trash" text rounded severity="danger" aria-label="Delete" @click.stop="remove(data)" /></template>
        </Column>
      </DataTable>
    </div>
  </div>
</template>

<style scoped>
.narrow { max-width: 900px; }
</style>
