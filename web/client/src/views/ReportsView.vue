<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import { api, qs } from '../lib/api';
import { downloadCsv, fmtDate, fmtMoney, fmtTime, today } from '../lib/format';
import { useUi } from '../lib/ui';
import { useAuth } from '../stores/auth';

/** Reports of UntReports / UntLogReports. */
const ui = useUi();
const auth = useAuth();
const router = useRouter();

type Col = { field: string; header: string; type?: 'date' | 'time' | 'money' | 'yn' | 'num' };
interface ReportDef { key: string; label: string; url: string; filters: string[]; cols: Col[]; sum?: string[]; currencyField?: string; link?: (r: any) => string; admin?: boolean }

const REPORTS: ReportDef[] = [
  {
    key: 'reservations', label: 'Reservations', url: '/api/reports/reservations', filters: ['dateField', 'carModel', 'carRegNo', 'agency', 'company', 'currency', 'customer', 'unpaid'],
    cols: [
      { field: 'id', header: '#' }, { field: 'Name', header: 'Name' }, { field: 'Surname', header: 'Surname' }, { field: 'CarModel', header: 'Model' },
      { field: 'CarRegNo', header: 'Reg. no' }, { field: 'BirakilacakTarih', header: 'Deliver', type: 'date' }, { field: 'AlinacakTarih', header: 'Collect', type: 'date' },
      { field: 'TotalDays', header: 'Days', type: 'num' }, { field: 'Agency', header: 'Agency' }, { field: 'currency', header: 'Cur.' },
      { field: 'GeneralTotal', header: 'Total', type: 'money' }, { field: 'Discount', header: 'Discount', type: 'money' }, { field: 'Paid', header: 'Paid', type: 'money' },
      { field: 'OutstandingBalance', header: 'Balance', type: 'money' }, { field: 'TotalComission', header: 'Commission', type: 'money' },
    ],
    sum: ['GeneralTotal', 'Discount', 'Paid', 'OutstandingBalance', 'TotalComission'], currencyField: 'currency', link: (r) => `/reservations/${r.id}`,
  },
  {
    key: 'agency', label: 'Agency commission', url: '/api/reports/agency-commission', filters: ['agency'],
    cols: [
      { field: 'Agency', header: 'Agency' }, { field: 'id', header: '#' }, { field: 'Name', header: 'Name' }, { field: 'Surname', header: 'Surname' },
      { field: 'BirakilacakTarih', header: 'Deliver', type: 'date' }, { field: 'AlinacakTarih', header: 'Collect', type: 'date' }, { field: 'TotalDays', header: 'Days', type: 'num' },
      { field: 'currency', header: 'Cur.' }, { field: 'TotalComission', header: 'Commission', type: 'money' },
    ],
    sum: ['TotalComission'], currencyField: 'currency', link: (r) => `/reservations/${r.id}`,
  },
  {
    key: 'company', label: 'Company income', url: '/api/reports/company-income', filters: ['company'],
    cols: [
      { field: 'Company', header: 'Company' }, { field: 'id', header: '#' }, { field: 'Name', header: 'Name' }, { field: 'Surname', header: 'Surname' },
      { field: 'CarRegNo', header: 'Car' }, { field: 'BirakilacakTarih', header: 'Deliver', type: 'date' }, { field: 'AlinacakTarih', header: 'Collect', type: 'date' },
      { field: 'TotalDays', header: 'Days', type: 'num' }, { field: 'currency', header: 'Cur.' }, { field: 'GeneralTotal', header: 'Total', type: 'money' },
      { field: 'Companyincome', header: 'Company income', type: 'money' },
    ],
    sum: ['GeneralTotal', 'Companyincome'], currencyField: 'currency', link: (r) => `/reservations/${r.id}`,
  },
  {
    key: 'usage', label: 'Car usage (rented days)', url: '/api/reports/car-usage', filters: [],
    cols: [
      { field: 'CarModel', header: 'Model' }, { field: 'CarRegNo', header: 'Reg. no' }, { field: 'Rentals', header: 'Rentals', type: 'num' },
      { field: 'Days', header: 'Rented days', type: 'num' }, { field: 'PeriodDays', header: 'Days in period', type: 'num' }, { field: 'usage', header: 'Usage %', type: 'num' },
    ],
  },
  {
    key: 'customers', label: 'Customer ranking', url: '/api/reports/customer-ranking', filters: [],
    cols: [{ field: 'Name', header: 'Name' }, { field: 'Surname', header: 'Surname' }, { field: 'Rentals', header: 'Rentals', type: 'num' }, { field: 'Days', header: 'Days', type: 'num' }],
  },
  {
    key: 'costs', label: 'Car costs', url: '/api/reports/car-costs', filters: ['carId'],
    cols: [
      { field: 'Kind', header: 'Kind' }, { field: 'CarModel', header: 'Model' }, { field: 'CarRegNo', header: 'Reg. no' }, { field: 'Date', header: 'Date', type: 'date' },
      { field: 'Description', header: 'Description' }, { field: 'TL', header: 'TL', type: 'money' }, { field: 'Sterlin', header: '£', type: 'money' }, { field: 'Euro', header: '€', type: 'money' },
    ],
    sum: ['TL', 'Sterlin', 'Euro'],
  },
  {
    key: 'taxi', label: 'Taxi (from reservations)', url: '/api/reports/taxi', filters: [],
    cols: [
      { field: 'id', header: '#' }, { field: 'Name', header: 'Name' }, { field: 'Surname', header: 'Surname' }, { field: 'FlightNumber', header: 'Flight' },
      { field: 'TaxiDateDeliver', header: 'Pick-up date', type: 'date' }, { field: 'TaxiTimeDeliver', header: 'Time', type: 'time' }, { field: 'TaxiDeliverFrom', header: 'From' }, { field: 'TaxiDeliverTo', header: 'To' },
      { field: 'TaxiPickUp', header: 'Price', type: 'money' }, { field: 'TaxiDateCollect', header: 'Drop-off date', type: 'date' }, { field: 'TaxiTimeCollect', header: 'Time', type: 'time' },
      { field: 'TaxiCollectFrom', header: 'From' }, { field: 'TaxiCollectTo', header: 'To' }, { field: 'TaxiDropOff', header: 'Price', type: 'money' }, { field: 'currency', header: 'Cur.' },
    ],
    sum: ['TaxiPickUp', 'TaxiDropOff'], currencyField: 'currency', link: (r) => `/reservations/${r.id}`,
  },
  {
    key: 'transfers', label: 'Transfers', url: '/api/reports/transfers', filters: [],
    cols: [
      { field: 'Name', header: 'Name' }, { field: 'Surname', header: 'Surname' }, { field: 'AgencyName', header: 'Agency' }, { field: 'Driver', header: 'Driver' },
      { field: 'ArrivalDate', header: 'Arrival', type: 'date' }, { field: 'ArrivalTime', header: 'Time', type: 'time' }, { field: 'ArrivalFlightNo', header: 'Flight' },
      { field: 'ArrivalPrice', header: 'Arr. price', type: 'money' }, { field: 'ArrivalPaid', header: 'Paid', type: 'yn' },
      { field: 'DepartureDate', header: 'Departure', type: 'date' }, { field: 'DepartureTime', header: 'Time', type: 'time' },
      { field: 'DeparturePrice', header: 'Dep. price', type: 'money' }, { field: 'DeparturePaid', header: 'Paid', type: 'yn' }, { field: 'Currency', header: 'Cur.' },
    ],
    sum: ['ArrivalPrice', 'DeparturePrice'], currencyField: 'Currency', link: (r) => `/transfers/${r.id}`,
  },
  {
    key: 'customerlist', label: 'Customer list / e-mails', url: '/api/reports/customers', filters: ['noDates'],
    cols: [
      { field: 'Name', header: 'Name' }, { field: 'Surname', header: 'Surname' }, { field: 'Email', header: 'E-mail' }, { field: 'TelNo', header: 'Phone' },
      { field: 'PassportId', header: 'Passport' }, { field: 'BirthDate', header: 'Birth date', type: 'date' }, { field: 'BlackList', header: 'Black list', type: 'yn' },
    ],
    link: (r) => `/customers/${r.id}`,
  },
  { key: 'log', label: 'Reservation log', url: '/api/reports/log', filters: ['user'], cols: [], admin: true },
];

const available = computed(() => REPORTS.filter((r) => !r.admin || auth.can('admin')));
const current = ref<ReportDef>(REPORTS[0]);
const year = today().slice(0, 4);
const p = reactive<Record<string, any>>({ from: `${year}-01-01`, to: `${year}-12-31`, dateField: 'delivery', unpaid: false });
const rows = ref<any[]>([]);
const loading = ref(false);
const lookups = reactive({ agencies: [] as string[], companies: [] as string[], models: [] as string[], cars: [] as any[] });

const cols = computed<Col[]>(() =>
  current.value.cols.length ? current.value.cols : rows.value.length ? Object.keys(rows.value[0]).map((k) => ({ field: k, header: k })) : [],
);
const has = (f: string) => current.value.filters.includes(f);

async function run() {
  loading.value = true;
  try {
    const params: Record<string, unknown> = has('noDates') ? {} : { from: p.from, to: p.to };
    for (const f of current.value.filters) if (f !== 'noDates') params[f] = f === 'unpaid' ? (p.unpaid ? '1' : '') : p[f];
    let data: any[] = await api.get(`${current.value.url}${qs(params)}`);
    if (current.value.key === 'usage') data = data.map((r) => ({ ...r, usage: r.PeriodDays ? Math.round((Number(r.Days) / Number(r.PeriodDays)) * 1000) / 10 : 0 }));
    rows.value = data;
  } catch (e) {
    ui.error(e);
  } finally {
    loading.value = false;
  }
}

const totals = computed(() => {
  const def = current.value;
  if (!def.sum?.length) return [];
  const groups = new Map<string, Record<string, number>>();
  for (const r of rows.value) {
    const c = def.currencyField ? r[def.currencyField] || '-' : '';
    if (!groups.has(c)) groups.set(c, {});
    const g = groups.get(c)!;
    for (const f of def.sum) g[f] = (g[f] ?? 0) + Number(r[f] ?? 0);
  }
  return [...groups.entries()].map(([cur, sums]) => ({ cur, sums }));
});

function show(r: any, c: Col) {
  const v = r[c.field];
  if (c.type === 'date') return fmtDate(v);
  if (c.type === 'time') return fmtTime(v);
  if (c.type === 'money') return fmtMoney(v);
  if (c.type === 'yn') return v === 'Y' ? '✓' : '';
  return v;
}
function exportCsv() {
  downloadCsv(`${current.value.key}-${p.from}-${p.to}.csv`, rows.value.map((r) => Object.fromEntries(cols.value.map((c) => [c.field, show(r, c)]))), cols.value);
}
const printPage = () => window.print();

onMounted(async () => {
  try {
    const [a, c, m, cars] = await Promise.all([api.get('/api/agencies'), api.get('/api/companies'), api.get('/api/cars/models'), api.get('/api/cars?includeSold=1')]);
    lookups.agencies = a.map((x: any) => x.name);
    lookups.companies = c.map((x: any) => x.name);
    lookups.models = m;
    lookups.cars = cars.map((x: any) => ({ id: x.id, label: `${x.Model} ${x.RegNo}`, RegNo: x.RegNo }));
  } catch (e) {
    ui.error(e);
  }
});
</script>

<template>
  <div class="page reports">
    <div class="page-header"><h1>Reports</h1></div>
    <div class="card no-print">
      <div class="toolbar">
        <div class="field"><label>Report</label><Select v-model="current" :options="available" option-label="label" @change="rows = []" style="min-width: 230px" /></div>
        <template v-if="!has('noDates')">
          <div class="field"><label>From</label><input v-model="p.from" type="date" class="p-inputtext" /></div>
          <div class="field"><label>To</label><input v-model="p.to" type="date" class="p-inputtext" /></div>
        </template>
        <div v-if="has('dateField')" class="field"><label>Date is</label>
          <Select v-model="p.dateField" :options="[{ l: 'Delivery date', v: 'delivery' }, { l: 'Collection date', v: 'collection' }, { l: 'Booking date', v: 'booked' }]" option-label="l" option-value="v" />
        </div>
        <div v-if="has('agency')" class="field"><label>Agency</label><Select v-model="p.agency" :options="lookups.agencies" show-clear filter placeholder="All" /></div>
        <div v-if="has('company')" class="field"><label>Company</label><Select v-model="p.company" :options="lookups.companies" show-clear placeholder="All" /></div>
        <div v-if="has('carModel')" class="field"><label>Model</label><Select v-model="p.carModel" :options="lookups.models" show-clear filter placeholder="All" /></div>
        <div v-if="has('carRegNo')" class="field"><label>Reg. no</label><Select v-model="p.carRegNo" :options="lookups.cars" option-label="label" option-value="RegNo" show-clear filter placeholder="All" /></div>
        <div v-if="has('carId')" class="field"><label>Car</label><Select v-model="p.carId" :options="lookups.cars" option-label="label" option-value="id" show-clear filter placeholder="All" /></div>
        <div v-if="has('currency')" class="field"><label>Currency</label><Select v-model="p.currency" :options="['TL', 'EURO', 'STERLIN', 'DOLLAR']" show-clear placeholder="All" /></div>
        <div v-if="has('customer')" class="field"><label>Customer</label><InputText v-model="p.customer" /></div>
        <div v-if="has('user')" class="field"><label>User</label><InputText v-model="p.user" /></div>
        <label v-if="has('unpaid')" class="check"><Checkbox v-model="p.unpaid" binary /> Only with balance</label>
        <Button icon="pi pi-play" label="Run" :loading="loading" @click="run" />
        <Button icon="pi pi-file-excel" label="CSV" outlined :disabled="!rows.length" @click="exportCsv" />
        <Button icon="pi pi-print" label="Print" outlined :disabled="!rows.length" @click="printPage" />
      </div>
    </div>

    <div class="card">
      <h2>{{ current.label }} <span v-if="!has('noDates')" class="muted">{{ fmtDate(p.from) }} – {{ fmtDate(p.to) }}</span> <span class="muted">· {{ rows.length }} rows</span></h2>
      <DataTable :value="rows" size="small" striped-rows scrollable :loading="loading" paginator :rows="50" :rows-per-page-options="[50, 200, 1000]"
        row-hover :row-class="() => (current.link ? 'clickable-row' : '')" @row-click="(e: any) => current.link && router.push(current.link(e.data))">
        <template #empty>Choose a report and press Run.</template>
        <Column v-for="c in cols" :key="c.field + c.header" :field="c.field" :header="c.header" sortable :class="{ num: c.type === 'money' || c.type === 'num' }">
          <template #body="{ data }">{{ show(data, c) }}</template>
        </Column>
      </DataTable>
      <div v-if="totals.length" class="totals-box">
        <div v-for="t in totals" :key="t.cur" class="totals">
          <span v-if="t.cur">{{ t.cur }}:</span>
          <span v-for="(v, k) in t.sums" :key="k">{{ cols.find((c) => c.field === k)?.header ?? k }} {{ fmtMoney(v) }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.reports { max-width: none; }
.totals-box { border-top: 2px solid var(--app-border); margin-top: 8px; padding-top: 4px; }
</style>
