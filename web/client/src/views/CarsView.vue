<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { api } from '../lib/api';
import { addDays, CAR_GROUPS, fmtDate, toDateInput, today } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const router = useRouter();
const ui = useUi();
const auth = useAuth();
const cars = ref<any[]>([]);
const loading = ref(false);
const showSold = ref(false);
const search = ref('');
const group = ref('All');
const ordering = ref(false);

async function load() {
  loading.value = true;
  try {
    cars.value = await api.get(`/api/cars?includeSold=${showSold.value ? 1 : 0}`);
  } catch (e) {
    ui.error(e);
  } finally {
    loading.value = false;
  }
}
const visible = computed(() => {
  const s = search.value.toLowerCase();
  return cars.value.filter((c) =>
    (group.value === 'All' || c.Grup === group.value) &&
    (!s || `${c.Model} ${c.RegNo} ${c.Type}`.toLowerCase().includes(s)),
  );
});
/** Inspection (muayene) due within 30 days or overdue. */
const inspectionSoon = (d: string) => {
  const x = toDateInput(d);
  return !!x && x <= addDays(today(), 30);
};

// ---- order within a group (UntCarList) ----
async function saveOrder(rows: any[]) {
  try {
    await api.put('/api/cars/order', { ids: rows.map((r) => r.id) });
    ui.ok('Order saved');
    load();
  } catch (e) {
    ui.error(e);
  }
}
function onReorder(e: any) {
  saveOrder(e.value);
}
onMounted(load);
</script>

<template>
  <div class="page">
    <div class="page-header">
      <h1>Cars</h1>
      <Button v-if="auth.can('cars')" label="New car" icon="pi pi-plus" @click="router.push('/cars/new')" />
    </div>
    <div class="card">
      <div class="toolbar">
        <div class="field"><label>Search</label><InputText v-model="search" placeholder="Model or reg. no" /></div>
        <div class="field"><label>Group</label><Select v-model="group" :options="['All', ...CAR_GROUPS]" /></div>
        <label class="check"><Checkbox v-model="showSold" binary @change="load" /> Show sold cars</label>
        <label v-if="auth.can('cars') && group !== 'All'" class="check"><ToggleSwitch v-model="ordering" /> Change order (drag rows)</label>
      </div>
      <DataTable :value="visible" size="small" :loading="loading" row-hover striped-rows
        :row-class="() => (ordering ? '' : 'clickable-row')"
        @row-click="(e: any) => !ordering && router.push(`/cars/${e.data.id}`)" @row-reorder="onReorder">
        <template #empty>No cars.</template>
        <Column v-if="ordering" row-reorder style="width: 40px" />
        <Column field="Grup" header="Group" />
        <Column field="SiraNo" header="Order" class="num" />
        <Column field="Model" header="Model" />
        <Column field="RegNo" header="Reg. no" />
        <Column field="Type" header="Type" />
        <Column header="Inspection">
          <template #body="{ data }"><span :class="{ due: inspectionSoon(data.MuayeneTarihi) }">{{ fmtDate(data.MuayeneTarihi) }}</span></template>
        </Column>
        <Column header=""><template #body="{ data }"><Tag v-if="data.Sold == 1" value="Sold" severity="secondary" /></template></Column>
      </DataTable>
    </div>
  </div>
</template>

<style scoped>
.due { color: #dc2626; font-weight: 600; }
</style>
