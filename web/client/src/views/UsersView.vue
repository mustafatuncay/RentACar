<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { api } from '../lib/api';
import { useUi } from '../lib/ui';
import type { Permission } from '../stores/auth';

/** User administration (UntAdmin). */
const ui = useUi();
const rows = ref<any[]>([]);
const editing = ref<any | null>(null);
const PERMS: { value: Permission; label: string }[] = [
  { value: 'cars', label: 'Car Entry' },
  { value: 'timetable', label: 'Time Table / Reservations' },
  { value: 'customers', label: 'Customer Entry' },
  { value: 'reports', label: 'Reports' },
  { value: 'transfers', label: 'Transfers' },
  { value: 'admin', label: 'Admin' },
  { value: 'agency', label: 'Agency' },
];

async function load() {
  try { rows.value = await api.get('/api/users'); } catch (e) { ui.error(e); }
}
function open(u?: any) {
  editing.value = u ? { ...u, perms: [...u.perms], password: '', password2: '' } : { username: '', duty: '', description: '', perms: [], password: '', password2: '' };
}
async function save() {
  const u = editing.value;
  if (u.password !== u.password2) return ui.error(new Error('Passwords do not match'));
  if (!u.id && !u.password) return ui.error(new Error('Please enter a password'));
  try {
    const body = { username: u.username, duty: u.duty, description: u.description, perms: u.perms, password: u.password };
    if (u.id) await api.put(`/api/users/${u.id}`, body);
    else await api.post('/api/users', body);
    ui.ok('User saved');
    editing.value = null;
    load();
  } catch (e) { ui.error(e); }
}
async function remove() {
  if (!(await ui.ask(`Delete user ${editing.value.username}?`, 'Delete', true))) return;
  try { await api.del(`/api/users/${editing.value.id}`); editing.value = null; load(); } catch (e) { ui.error(e); }
}
onMounted(load);
</script>

<template>
  <div class="page narrow">
    <div class="page-header">
      <h1>Users</h1>
      <Button label="New user" icon="pi pi-user-plus" @click="open()" />
    </div>
    <div class="card">
      <DataTable :value="rows" size="small" striped-rows row-hover :row-class="() => 'clickable-row'" @row-click="(e: any) => open(e.data)">
        <Column field="username" header="Username" sortable />
        <Column field="duty" header="Duty" />
        <Column header="Permissions">
          <template #body="{ data }"><Tag v-for="p in data.perms" :key="p" :value="PERMS.find((x) => x.value === p)?.label ?? p" severity="secondary" class="mr" /></template>
        </Column>
      </DataTable>
    </div>
    <Dialog :visible="!!editing" modal :header="editing?.id ? 'Edit user' : 'New user'" style="width: 520px; max-width: 95vw" @update:visible="editing = null">
      <div v-if="editing" class="grid">
        <div class="field"><label>Username</label><InputText v-model="editing.username" autocomplete="off" /></div>
        <div class="field"><label>Duty</label><InputText v-model="editing.duty" /></div>
        <div class="field full"><label>Description</label><InputText v-model="editing.description" /></div>
        <div class="field"><label>{{ editing.id ? 'New password (leave empty to keep)' : 'Password' }}</label><InputText v-model="editing.password" type="password" autocomplete="new-password" /></div>
        <div class="field"><label>Repeat password</label><InputText v-model="editing.password2" type="password" autocomplete="new-password" /></div>
        <div class="field full">
          <label>Permissions</label>
          <div class="perms">
            <label v-for="p in PERMS" :key="p.value" class="check"><Checkbox v-model="editing.perms" :value="p.value" /> {{ p.label }}</label>
          </div>
        </div>
      </div>
      <template #footer>
        <Button v-if="editing?.id" label="Delete" icon="pi pi-trash" severity="danger" text @click="remove" />
        <Button label="Cancel" text @click="editing = null" />
        <Button label="Save" icon="pi pi-check" @click="save" />
      </template>
    </Dialog>
  </div>
</template>

<style scoped>
.narrow { max-width: 900px; }
.perms { display: grid; grid-template-columns: 1fr 1fr; gap: 6px; }
.mr { margin: 0 4px 2px 0; }
</style>
