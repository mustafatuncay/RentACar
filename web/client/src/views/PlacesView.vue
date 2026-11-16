<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { api } from '../lib/api';
import { useUi } from '../lib/ui';

/** Fixed deliver / collect places (UntSabitDegerler). */
const ui = useUi();
const rows = ref<any[]>([]);
const kind = ref(0);
const name = ref('');
const kinds = [{ label: 'Car Deliver', value: 0 }, { label: 'Car Collect', value: 1 }];
const visible = computed(() => rows.value.filter((r) => Number(r.kriterno) === kind.value));

async function load() {
  try { rows.value = await api.get('/api/places'); } catch (e) { ui.error(e); }
}
async function add() {
  try {
    await api.post('/api/places', { kriterno: kind.value, aciklama: name.value });
    name.value = '';
    load();
  } catch (e) { ui.error(e); }
}
async function remove(r: any) {
  if (!(await ui.ask(`Delete "${r.aciklama}"?`, 'Delete', true))) return;
  try { await api.del(`/api/places/${r.id}`); load(); } catch (e) { ui.error(e); }
}
onMounted(load);
</script>

<template>
  <div class="page narrow">
    <div class="page-header"><h1>Places</h1></div>
    <div class="card">
      <SelectButton v-model="kind" :options="kinds" option-label="label" option-value="value" :allow-empty="false" />
      <form class="toolbar mt" @submit.prevent="add">
        <div class="field grow"><label>New place</label><InputText v-model="name" /></div>
        <Button type="submit" label="Add" icon="pi pi-plus" :disabled="!name.trim()" />
      </form>
      <DataTable :value="visible" size="small" striped-rows>
        <template #empty>No places.</template>
        <Column field="aciklama" header="Place" sortable />
        <Column header="" style="width: 60px">
          <template #body="{ data }"><Button icon="pi pi-trash" text rounded severity="danger" aria-label="Delete" @click="remove(data)" /></template>
        </Column>
      </DataTable>
    </div>
  </div>
</template>

<style scoped>
.narrow { max-width: 720px; }
.grow { flex: 1; }
.mt { margin-top: 10px; }
</style>
