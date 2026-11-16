<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { api } from '../lib/api';
import { fmtDate, fmtMoney, fmtTime, today } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

const auth = useAuth();
const router = useRouter();
const ui = useUi();
const unpaid = ref<any[]>([]);
const birthdays = ref<any[]>([]);
const rates = ref<any[]>([]);
const day = ref<any>(null);
const loading = ref(true);

async function load() {
  loading.value = true;
  try {
    const jobs: Promise<unknown>[] = [
      api.get('/api/dashboard/unpaid').then((r) => (unpaid.value = r)),
      api.get('/api/customers/birthdays?days=3').then((r) => (birthdays.value = r)),
      api.get('/api/kur/latest').then((r) => (rates.value = r)),
    ];
    if (auth.can('timetable')) jobs.push(api.get(`/api/timetable/day?date=${today()}`).then((r) => (day.value = r)));
    await Promise.all(jobs);
  } catch (e) {
    ui.error(e);
  } finally {
    loading.value = false;
  }
}

async function markChecked(row: any) {
  try {
    await api.patch(`/api/reservations/${row.id}/kontrol`, { Kontrol: 'Y' });
    unpaid.value = unpaid.value.filter((r) => r.id !== row.id);
  } catch (e) {
    ui.error(e);
  }
}

onMounted(load);
</script>

<template>
  <div class="page">
    <div class="page-header">
      <h1>Welcome, {{ auth.user?.username }}</h1>
      <Button icon="pi pi-refresh" text rounded aria-label="Refresh" :loading="loading" @click="load" />
      <Button v-if="auth.can('timetable')" label="New reservation" icon="pi pi-plus" @click="router.push('/reservations/new')" />
    </div>

    <div class="dash">
      <section v-if="day" class="card">
        <h2><i class="pi pi-calendar" /> Today</h2>
        <div class="stats">
          <RouterLink to="/timetable" class="stat"><b>{{ day.deliveries.length }}</b><span>Deliveries</span></RouterLink>
          <RouterLink to="/timetable" class="stat"><b>{{ day.collections.length }}</b><span>Collections</span></RouterLink>
          <RouterLink to="/timetable" class="stat"><b>{{ day.arrivals.length + day.taxiDeliver.length }}</b><span>Arrivals</span></RouterLink>
          <RouterLink to="/timetable" class="stat"><b>{{ day.departures.length + day.taxiCollect.length }}</b><span>Departures</span></RouterLink>
        </div>
        <DataTable v-if="day.deliveries.length || day.collections.length" :value="[...day.deliveries.map((r: any) => ({ ...r, kind: 'Deliver', time: r.BirakilacakSaat, place: r.birakilacakYer })), ...day.collections.map((r: any) => ({ ...r, kind: 'Collect', time: r.AlinacakSaat, place: r.AlinacakYer }))]"
          size="small" class="mt" row-hover @row-click="(e: any) => router.push(`/reservations/${e.data.id}`)" :row-class="() => 'clickable-row'">
          <Column header="" style="width: 80px"><template #body="{ data }"><Tag :value="data.kind" :severity="data.kind === 'Deliver' ? 'success' : 'warn'" /></template></Column>
          <Column header="Time"><template #body="{ data }">{{ fmtTime(data.time) }}</template></Column>
          <Column header="Customer"><template #body="{ data }">{{ data.Name }} {{ data.Surname }}</template></Column>
          <Column field="CarRegNo" header="Car" />
          <Column field="place" header="Place" />
        </DataTable>
      </section>

      <section class="card">
        <h2><i class="pi pi-exclamation-circle" /> Unpaid balances ({{ unpaid.length }})</h2>
        <p class="muted small">Rentals already started with an outstanding balance. Tick when checked.</p>
        <DataTable :value="unpaid" size="small" scrollable scroll-height="360px" :loading="loading">
          <template #empty>No unpaid reservations.</template>
          <Column header="" style="width: 48px">
            <template #body="{ data }"><Checkbox :binary="true" :model-value="false" :aria-label="`Mark ${data.id} checked`" @update:model-value="markChecked(data)" /></template>
          </Column>
          <Column header="Customer">
            <template #body="{ data }"><RouterLink :to="`/reservations/${data.id}`">{{ data.Name }} {{ data.Surname }}</RouterLink></template>
          </Column>
          <Column header="Deliver"><template #body="{ data }">{{ fmtDate(data.BirakilacakTarih) }}</template></Column>
          <Column header="Balance" class="num"><template #body="{ data }">{{ fmtMoney(data.OutstandingBalance, data.currency) }}</template></Column>
        </DataTable>
      </section>

      <section class="card">
        <h2><i class="pi pi-gift" /> Birthdays (next 3 days)</h2>
        <DataTable :value="birthdays" size="small">
          <template #empty>No birthdays.</template>
          <Column header="Date"><template #body="{ data }">{{ fmtDate(data.BirthDate).slice(0, 5) }}</template></Column>
          <Column header="Customer">
            <template #body="{ data }"><RouterLink :to="`/customers/${data.id}`">{{ data.Name }} {{ data.Surname }}</RouterLink></template>
          </Column>
          <Column field="TelNo" header="Phone" />
        </DataTable>
      </section>

      <section class="card">
        <h2><i class="pi pi-pound" /> Exchange rates</h2>
        <DataTable :value="rates" size="small">
          <template #empty>No rates. <RouterLink to="/rates">Enter rates</RouterLink></template>
          <Column field="parabirimi" header="Currency" />
          <Column header="Buying" class="num"><template #body="{ data }">{{ Number(data.alis).toFixed(4) }}</template></Column>
          <Column header="Selling" class="num"><template #body="{ data }">{{ Number(data.satis).toFixed(4) }}</template></Column>
          <Column header="Date"><template #body="{ data }">{{ fmtDate(data.tarih) }}</template></Column>
        </DataTable>
      </section>
    </div>
  </div>
</template>

<style scoped>
.dash { display: grid; grid-template-columns: repeat(auto-fit, minmax(340px, 1fr)); gap: 14px; align-items: start; }
.dash .card { margin: 0; }
.stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 8px; }
.stat { display: flex; flex-direction: column; align-items: center; padding: 10px 4px; border-radius: 8px; background: var(--app-bg); text-decoration: none; }
.stat b { font-size: 1.5rem; }
.stat span { font-size: 12px; color: var(--app-muted); }
.small { font-size: 12px; margin: 0 0 8px; }
.mt { margin-top: 10px; }
@media (max-width: 420px) { .dash { grid-template-columns: 1fr; } }
</style>
