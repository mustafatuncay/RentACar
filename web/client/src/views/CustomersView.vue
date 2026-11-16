<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { api, qs } from '../lib/api';
import { fmtDate } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const router = useRouter();
const ui = useUi();
const auth = useAuth();
const rows = ref<any[]>([]);
const search = ref('');
const blacklist = ref(false);
const loading = ref(false);

async function load() {
  loading.value = true;
  try {
    rows.value = await api.get(`/api/customers${qs({ search: search.value, blacklist: blacklist.value ? 'Y' : '' })}`);
  } catch (e) {
    ui.error(e);
  } finally {
    loading.value = false;
  }
}
onMounted(load);
</script>

<template>
  <div class="page">
    <div class="page-header">
      <h1>Customers</h1>
      <Button v-if="auth.can('customers')" label="New customer" icon="pi pi-user-plus" @click="router.push('/customers/new')" />
    </div>
    <div class="card">
      <form class="toolbar" @submit.prevent="load">
        <div class="field"><label>Search</label><InputText v-model="search" placeholder="Name, passport, phone, e-mail" /></div>
        <label class="check"><Checkbox v-model="blacklist" binary /> Only black list</label>
        <Button type="submit" icon="pi pi-search" label="Search" :loading="loading" />
      </form>
      <DataTable :value="rows" size="small" paginator :rows="25" :loading="loading" row-hover striped-rows
        :row-class="() => 'clickable-row'" @row-click="(e: any) => router.push(`/customers/${e.data.id}`)">
        <template #empty>No customers.</template>
        <Column header="Name" sortable sort-field="Surname">
          <template #body="{ data }">{{ data.Name }} {{ data.Surname }} <Tag v-if="data.BlackList === 'Y'" value="Black list" severity="danger" /></template>
        </Column>
        <Column field="PassportId" header="Passport" />
        <Column field="LicenseNo" header="Licence" />
        <Column header="Phone"><template #body="{ data }">{{ data.TelNo || data.LocalNumber || data.CyprusMobile }}</template></Column>
        <Column field="Email" header="E-mail" />
        <Column header="Birth date"><template #body="{ data }">{{ fmtDate(data.BirthDate) }}</template></Column>
      </DataTable>
    </div>
  </div>
</template>
