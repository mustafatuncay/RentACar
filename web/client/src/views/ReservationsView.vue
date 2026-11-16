<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { api, qs } from '../lib/api';
import { fmtDate, fmtMoney, fmtTime } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const router = useRouter();
const ui = useUi();
const auth = useAuth();
const rows = ref<any[]>([]);
const loading = ref(false);
const search = ref('');
const from = ref('');
const to = ref('');
const unpaid = ref(false);

async function load() {
  loading.value = true;
  try {
    rows.value = await api.get(`/api/reservations${qs({ search: search.value, from: from.value, to: to.value, unpaid: unpaid.value ? 1 : '' })}`);
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
      <h1>Reservations</h1>
      <Button v-if="auth.can('timetable')" label="New" icon="pi pi-plus" @click="router.push('/reservations/new')" />
    </div>
    <div class="card">
      <form class="toolbar" @submit.prevent="load">
        <div class="field"><label>Search</label><InputText v-model="search" placeholder="Name, reg. no, contract, #id" /></div>
        <div class="field"><label>From</label><input v-model="from" type="date" class="p-inputtext" /></div>
        <div class="field"><label>To</label><input v-model="to" type="date" class="p-inputtext" /></div>
        <label class="check"><Checkbox v-model="unpaid" binary /> Only with balance</label>
        <Button type="submit" icon="pi pi-search" label="Search" :loading="loading" />
      </form>
      <DataTable :value="rows" size="small" paginator :rows="25" :loading="loading" row-hover striped-rows
        :row-class="() => 'clickable-row'" @row-click="(e: any) => router.push(`/reservations/${e.data.id}`)" sort-mode="single">
        <template #empty>No reservations.</template>
        <Column field="id" header="#" sortable style="width: 70px" />
        <Column header="Customer" sortable sort-field="Surname"><template #body="{ data }">{{ data.Name }} {{ data.Surname }}</template></Column>
        <Column header="Car"><template #body="{ data }">{{ data.CarModel }} <span class="muted">{{ data.CarRegNo }}</span></template></Column>
        <Column header="Deliver" sortable sort-field="BirakilacakTarih"><template #body="{ data }">{{ fmtDate(data.BirakilacakTarih) }} {{ fmtTime(data.BirakilacakSaat) }}</template></Column>
        <Column header="Collect" sortable sort-field="AlinacakTarih"><template #body="{ data }">{{ fmtDate(data.AlinacakTarih) }} {{ fmtTime(data.AlinacakSaat) }}</template></Column>
        <Column field="TotalDays" header="Days" class="num" />
        <Column field="Agency" header="Agency" />
        <Column header="Total" class="num"><template #body="{ data }">{{ fmtMoney(data.GeneralTotal, data.currency) }}</template></Column>
        <Column header="Balance" class="num" sortable sort-field="OutstandingBalance">
          <template #body="{ data }"><span :class="{ due: Number(data.OutstandingBalance) > 0 }">{{ fmtMoney(data.OutstandingBalance, data.currency) }}</span></template>
        </Column>
      </DataTable>
    </div>
  </div>
</template>

<style scoped>
.due { color: #dc2626; font-weight: 600; }
</style>
