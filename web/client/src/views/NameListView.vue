<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { api } from '../lib/api';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

/** Agencies (UntAgency) and companies (UntCompany): simple name lists. */
const props = defineProps<{ kind: 'agencies' | 'companies' }>();
const ui = useUi();
const auth = useAuth();
const rows = ref<any[]>([]);
const name = ref('');
const editing = ref<any | null>(null);
const title = computed(() => (props.kind === 'agencies' ? 'Agencies' : 'Companies'));
const canEdit = computed(() => auth.can(props.kind === 'agencies' ? 'agency' : 'admin'));

async function load() {
  try { rows.value = await api.get(`/api/${props.kind}`); } catch (e) { ui.error(e); }
}
async function add() {
  if (!name.value.trim()) return;
  try {
    await api.post(`/api/${props.kind}`, { name: name.value });
    name.value = '';
    load();
  } catch (e) { ui.error(e); }
}
async function rename() {
  try {
    await api.put(`/api/${props.kind}/${editing.value.id}`, { name: editing.value.name });
    ui.ok('Saved. Existing reservations were updated too.');
    editing.value = null;
    load();
  } catch (e) { ui.error(e); }
}
async function remove(row: any) {
  if (!(await ui.ask(`Delete "${row.name}"?`, 'Delete', true))) return;
  try { await api.del(`/api/${props.kind}/${row.id}`); load(); } catch (e) { ui.error(e); }
}
onMounted(load);
</script>

<template>
  <div class="page narrow">
    <div class="page-header"><h1>{{ title }}</h1></div>
    <div class="card">
      <form v-if="canEdit" class="toolbar" @submit.prevent="add">
        <div class="field grow"><label>New name</label><InputText v-model="name" /></div>
        <Button type="submit" label="Add" icon="pi pi-plus" :disabled="!name.trim()" />
      </form>
      <DataTable :value="rows" size="small" striped-rows>
        <template #empty>No records.</template>
        <Column field="name" header="Name" sortable />
        <Column v-if="canEdit" header="" style="width: 110px">
          <template #body="{ data }">
            <Button icon="pi pi-pencil" text rounded aria-label="Rename" @click="editing = { ...data }" />
            <Button icon="pi pi-trash" text rounded severity="danger" aria-label="Delete" @click="remove(data)" />
          </template>
        </Column>
      </DataTable>
    </div>
    <Dialog :visible="!!editing" modal header="Rename" style="width: 380px; max-width: 95vw" @update:visible="editing = null">
      <InputText v-if="editing" v-model="editing.name" class="w-full" />
      <p class="muted small">The name is also changed on existing reservations and transfers.</p>
      <template #footer>
        <Button label="Cancel" text @click="editing = null" />
        <Button label="Save" icon="pi pi-check" @click="rename" />
      </template>
    </Dialog>
  </div>
</template>

<style scoped>
.narrow { max-width: 720px; }
.grow { flex: 1; }
.w-full { width: 100%; }
.small { font-size: 12px; }
</style>
