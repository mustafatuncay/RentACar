<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { api } from '../lib/api';
import { fmtDate, fmtMoney, toDateInput } from '../lib/format';
import { useUi } from '../lib/ui';

/**
 * Generic list + edit dialog for a car's expenses / insurance / seyrüsefer records.
 * `fields` describes the inputs; `columns` what is shown in the table.
 */
export interface FieldDef { key: string; label: string; type: 'text' | 'date' | 'money' | 'number' | 'memo' }
const props = defineProps<{ carId: number; kind: string; fields: FieldDef[]; columns: string[]; canEdit: boolean; title: string }>();
const ui = useUi();
const rows = ref<any[]>([]);
const editing = ref<any | null>(null);
const editId = ref<number | null>(null);

const url = computed(() => `/api/cars/${props.carId}/${props.kind}`);
async function load() {
  try { rows.value = await api.get(url.value); } catch (e) { ui.error(e); }
}
function open(row?: any) {
  editId.value = row?.id ?? null;
  const o: any = {};
  for (const f of props.fields) {
    const v = row?.[f.key];
    o[f.key] = f.type === 'date' ? toDateInput(v) : f.type === 'money' || f.type === 'number' ? Number(v ?? 0) : (v ?? '');
  }
  editing.value = o;
}
async function save() {
  try {
    if (editId.value) await api.put(`${url.value}/${editId.value}`, editing.value);
    else await api.post(url.value, editing.value);
    editing.value = null;
    ui.ok('Saved');
    load();
  } catch (e) {
    ui.error(e);
  }
}
async function remove() {
  if (!(await ui.ask('Delete this record?', 'Delete', true))) return;
  try {
    await api.del(`${url.value}/${editId.value}`);
    editing.value = null;
    load();
  } catch (e) {
    ui.error(e);
  }
}
const fieldOf = (k: string) => props.fields.find((f) => f.key === k);
const EXTRA_LABELS: Record<string, string> = { totalprice: 'Total TL', totalpriceSterlin: 'Total £', totalpriceEuro: 'Total €' };
function show(row: any, k: string) {
  const f = fieldOf(k);
  if (f?.type === 'date') return fmtDate(row[k]);
  if (f?.type === 'money' || k.toLowerCase().startsWith('total')) return fmtMoney(row[k]);
  return row[k];
}
const totals = computed(() => {
  const out: Record<string, number> = {};
  for (const k of props.columns) {
    const f = fieldOf(k);
    if (f?.type === 'money' || k.toLowerCase().startsWith('total')) out[k] = rows.value.reduce((a, r) => a + Number(r[k] ?? 0), 0);
  }
  return out;
});
onMounted(load);
</script>

<template>
  <div>
    <div class="row head">
      <span class="muted">{{ rows.length }} records</span>
      <Button v-if="canEdit" label="Add" icon="pi pi-plus" size="small" @click="open()" />
    </div>
    <DataTable :value="rows" size="small" row-hover :row-class="() => 'clickable-row'" @row-click="(e: any) => open(e.data)" scrollable>
      <template #empty>No records.</template>
      <Column v-for="k in columns" :key="k" :header="fieldOf(k)?.label ?? EXTRA_LABELS[k] ?? k" :class="{ num: fieldOf(k)?.type === 'money' || k.toLowerCase().startsWith('total') }">
        <template #body="{ data }">{{ show(data, k) }}</template>
        <template v-if="totals[k] !== undefined" #footer><b>{{ fmtMoney(totals[k]) }}</b></template>
      </Column>
    </DataTable>

    <Dialog :visible="!!editing" modal :header="title" style="width: 640px; max-width: 95vw" @update:visible="editing = null">
      <fieldset v-if="editing" :disabled="!canEdit" class="plain grid">
        <div v-for="f in fields" :key="f.key" class="field" :class="{ full: f.type === 'memo' }">
          <label>{{ f.label }}</label>
          <input v-if="f.type === 'date'" v-model="editing[f.key]" type="date" class="p-inputtext" />
          <InputNumber v-else-if="f.type === 'money'" v-model="editing[f.key]" :min-fraction-digits="2" :max-fraction-digits="2" />
          <InputNumber v-else-if="f.type === 'number'" v-model="editing[f.key]" />
          <Textarea v-else-if="f.type === 'memo'" v-model="editing[f.key]" rows="2" auto-resize />
          <InputText v-else v-model="editing[f.key]" />
        </div>
      </fieldset>
      <template #footer>
        <Button v-if="canEdit && editId" label="Delete" icon="pi pi-trash" severity="danger" text @click="remove" />
        <Button label="Close" text @click="editing = null" />
        <Button v-if="canEdit" label="Save" icon="pi pi-check" @click="save" />
      </template>
    </Dialog>
  </div>
</template>

<style scoped>
.head { justify-content: space-between; margin-bottom: 8px; }
.plain { border: 0; padding: 0; margin: 0; }
</style>
