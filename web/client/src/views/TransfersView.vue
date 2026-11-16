<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { api, qs } from '../lib/api';
import { addDays, fmtDate, fmtMoney, fmtTime, today } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const router = useRouter();
const ui = useUi();
const auth = useAuth();
const rows = ref<any[]>([]);
const loading = ref(false);
const search = ref('');
const from = ref(addDays(today(), -7));
const to = ref(addDays(today(), 30));

async function load() {
  loading.value = true;
  try {
    rows.value = await api.get(`/api/transfers${qs({ search: search.value, from: from.value, to: to.value })}`);
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
      <h1>Transfers</h1>
      <Button v-if="auth.can('transfers')" label="New transfer" icon="pi pi-plus" @click="router.push('/transfers/new')" />
    </div>
    <div class="card">
      <form class="toolbar" @submit.prevent="load">
        <div class="field"><label>Search</label><InputText v-model="search" placeholder="Name, flight, driver" /></div>
        <div class="field"><label>From</label><input v-model="from" type="date" class="p-inputtext" /></div>
        <div class="field"><label>To</label><input v-model="to" type="date" class="p-inputtext" /></div>
        <Button type="submit" icon="pi pi-search" label="Search" :loading="loading" />
      </form>
      <DataTable :value="rows" size="small" paginator :rows="25" :loading="loading" row-hover striped-rows
        :row-class="() => 'clickable-row'" @row-click="(e: any) => router.push(`/transfers/${e.data.id}`)">
        <template #empty>No transfers.</template>
        <Column header="Customer"><template #body="{ data }">{{ data.Name }} {{ data.Surname }}</template></Column>
        <Column header="Arrival">
          <template #body="{ data }"><span v-if="data.CheckedArrival === 'Y'">{{ fmtDate(data.ArrivalDate) }} {{ fmtTime(data.ArrivalTime) }} · {{ data.ArrivalCollectFrom }} → {{ data.ArrivalDestination }}</span></template>
        </Column>
        <Column header="Departure">
          <template #body="{ data }"><span v-if="data.CheckedDeparture === 'Y'">{{ fmtDate(data.DepartureDate) }} {{ fmtTime(data.DepartureTime) }} · {{ data.DepartureCollectFrom }} → {{ data.DepartureDestination }}</span></template>
        </Column>
        <Column field="Driver" header="Driver" />
        <Column field="AgencyName" header="Agency" />
        <Column header="Price" class="num">
          <template #body="{ data }">{{ fmtMoney(Number(data.ArrivalPrice) * (data.CheckedArrival === 'Y' ? 1 : 0) + Number(data.DeparturePrice) * (data.CheckedDeparture === 'Y' ? 1 : 0), data.Currency) }}</template>
        </Column>
        <Column header="Res."><template #body="{ data }">{{ data.RegNo ? '#' + data.RegNo : '' }}</template></Column>
      </DataTable>
    </div>
  </div>
</template>
