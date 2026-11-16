<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { api } from '../lib/api';
import { CURRENCY_SYMBOL, fmtDate, fmtMoney, fmtTime } from '../lib/format';

/** Printable reservation (replaces QuickReport RepReservation). Use the browser's Print / Save as PDF. */
const route = useRoute();
const router = useRouter();
const r = ref<any>(null);
const error = ref('');
const printedAt = new Date().toLocaleString('en-GB');
const cur = computed(() => CURRENCY_SYMBOL[r.value?.currency] ?? r.value?.currency ?? '');
const m = (v: unknown) => `${fmtMoney(v)} ${cur.value}`;
const paid = computed(() =>
  [1, 2, 3, 4]
    .map((n) => ({ method: r.value?.[`PaymentMethod${n}`], amount: Number(r.value?.[`PaidAmount${n}`] ?? 0), note: r.value?.[`PaidNote${n}`] }))
    .filter((p) => p.amount),
);

const doPrint = () => window.print();

onMounted(async () => {
  try {
    r.value = await api.get(`/api/reservations/${route.params.id}`);
    setTimeout(() => window.print(), 300);
  } catch (e) {
    error.value = (e as Error).message;
  }
});
</script>

<template>
  <div class="print-page">
    <div class="no-print bar">
      <Button icon="pi pi-arrow-left" label="Back" text @click="router.back()" />
      <Button icon="pi pi-print" label="Print / Save as PDF" @click="doPrint" />
    </div>
    <p v-if="error" class="err">{{ error }}</p>
    <article v-if="r" class="sheet">
      <header>
        <div><h1>RESERVATION</h1><div class="muted">Printed {{ printedAt }}</div></div>
        <div class="no">No <b>{{ r.id }}</b><div v-if="r.ContractNumber">Contract {{ r.ContractNumber }}</div></div>
      </header>

      <section class="cols">
        <div>
          <h2>Customer</h2>
          <dl>
            <dt>Name</dt><dd>{{ r.Name }} {{ r.Surname }}</dd>
            <dt>Contact</dt><dd>{{ r.ContactNumber }}</dd>
            <dt>Passport</dt><dd>{{ r.PassportId }}</dd>
            <dt>Licence</dt><dd>{{ r.LicenseNo }}</dd>
            <dt>Place of birth</dt><dd>{{ r.PlaceofBirth }}</dd>
            <dt v-if="r.Name2">2nd driver</dt><dd v-if="r.Name2">{{ r.Name2 }} {{ r.Surname2 }}</dd>
            <dt>Agency</dt><dd>{{ r.Agency }}</dd>
            <dt>Voucher / Room</dt><dd>{{ r.VoucherNo }} {{ r.RoomNo ? '/ ' + r.RoomNo : '' }}</dd>
          </dl>
        </div>
        <div>
          <h2>Car</h2>
          <dl>
            <dt>Model</dt><dd>{{ r.CarModel }}</dd>
            <dt>Reg. no</dt><dd>{{ r.CarRegNo }}</dd>
            <dt>Deliver</dt><dd>{{ fmtDate(r.BirakilacakTarih) }} {{ r.DeliverTimeChecked === 'Y' ? fmtTime(r.BirakilacakSaat) : '' }} – {{ r.birakilacakYer }}</dd>
            <dt>Collect</dt><dd>{{ fmtDate(r.AlinacakTarih) }} {{ r.CollectTimeChecked === 'Y' ? fmtTime(r.AlinacakSaat) : '' }} – {{ r.AlinacakYer }}</dd>
            <dt>Flight</dt><dd>{{ r.FlightNumber }} {{ r.ChkFlightTime === 'Y' ? fmtTime(r.FlightTime) : '' }} {{ r.ChkFlightTime2 === 'Y' ? '/ return ' + fmtTime(r.DtFlightTime2) : '' }}</dd>
            <dt>Seats</dt><dd>Baby {{ r.BabySeat || 0 }} · Booster {{ r.BoosterSeat || 0 }} · Infant {{ r.infantSeat || 0 }}</dd>
          </dl>
          <p v-if="r.BirakilacakNotlar" class="note">Deliver: {{ r.BirakilacakNotlar }}</p>
          <p v-if="r.AlinacakNotlar" class="note">Collect: {{ r.AlinacakNotlar }}</p>
        </div>
      </section>

      <section v-if="r.TaxiDeliverFrom || r.TaxiCollectFrom">
        <h2>Taxi</h2>
        <table>
          <tr><th></th><th>Date</th><th>Time</th><th>From</th><th>To</th><th>Pax</th><th class="num">Price</th></tr>
          <tr v-if="r.TaxiDeliverFrom"><td>Pick up</td><td>{{ fmtDate(r.TaxiDateDeliver) }}</td><td>{{ fmtTime(r.TaxiTimeDeliver) }}</td><td>{{ r.TaxiDeliverFrom }}</td><td>{{ r.TaxiDeliverTo }}</td><td>{{ r.PaxsPickUp }}</td><td class="num">{{ m(r.TaxiPickUp) }}</td></tr>
          <tr v-if="r.TaxiCollectFrom"><td>Drop off</td><td>{{ fmtDate(r.TaxiDateCollect) }}</td><td>{{ fmtTime(r.TaxiTimeCollect) }}</td><td>{{ r.TaxiCollectFrom }}</td><td>{{ r.TaxiCollectTo }}</td><td>{{ r.PaxsDropOff }}</td><td class="num">{{ m(r.TaxiDropOff) }}</td></tr>
        </table>
      </section>

      <section>
        <h2>Price</h2>
        <table>
          <tr><th></th><th class="num">Rate</th><th class="num">Days</th><th class="num">Total</th></tr>
          <tr v-if="Number(r.LowSeasonDays)"><td>Low season</td><td class="num">{{ m(r.LowSeasonRate) }}</td><td class="num">{{ r.LowSeasonDays }}</td><td class="num">{{ m(r.LowSeasonTotal) }}</td></tr>
          <tr v-if="Number(r.MidSeasonDays)"><td>Mid season</td><td class="num">{{ m(r.MidSeasonRate) }}</td><td class="num">{{ r.MidSeasonDays }}</td><td class="num">{{ m(r.MidSeasonTotal) }}</td></tr>
          <tr v-if="Number(r.HighSeasonDays)"><td>High season</td><td class="num">{{ m(r.HighSeasonRate) }}</td><td class="num">{{ r.HighSeasonDays }}</td><td class="num">{{ m(r.HighSeasonTotal) }}</td></tr>
          <tr v-if="Number(r.ExtensionDays)"><td>Extension</td><td class="num">{{ m(r.ExtensionRate) }}</td><td class="num">{{ r.ExtensionDays }}</td><td class="num">{{ m(r.ExtensionTotal) }}</td></tr>
          <tr v-if="Number(r.Totalinsurance)"><td>Insurance</td><td class="num">{{ m(r.Dailyinsurance) }}</td><td class="num">{{ r.TotalDays }}</td><td class="num">{{ m(r.Totalinsurance) }}</td></tr>
          <tr v-if="Number(r.Petrol)"><td colspan="3">Petrol</td><td class="num">{{ m(r.Petrol) }}</td></tr>
          <tr v-if="Number(r.Extra)"><td colspan="3">Extra</td><td class="num">{{ m(r.Extra) }}</td></tr>
          <tr v-if="Number(r.TaxiPickUp) + Number(r.TaxiDropOff)"><td colspan="3">Taxi</td><td class="num">{{ m(Number(r.TaxiPickUp) + Number(r.TaxiDropOff)) }}</td></tr>
          <tr class="strong"><td colspan="2">Total ({{ r.TotalDays }} days)</td><td></td><td class="num">{{ m(r.GeneralTotal) }}</td></tr>
          <tr v-if="Number(r.Discount)"><td colspan="3">Discount</td><td class="num">- {{ m(r.Discount) }}</td></tr>
          <tr v-for="(p, i) in paid" :key="i"><td colspan="3">Paid {{ p.method }} {{ p.note }}</td><td class="num">- {{ m(p.amount) }}</td></tr>
          <tr class="strong"><td colspan="3">Balance</td><td class="num">{{ m(r.OutstandingBalance) }}</td></tr>
        </table>
      </section>

      <section v-if="r.Notes"><h2>Notes</h2><p class="pre">{{ r.Notes }}</p></section>

      <footer class="sign">
        <div>Customer signature</div>
        <div>Company signature</div>
      </footer>
    </article>
  </div>
</template>

<style scoped>
.print-page { background: #e5e7eb; min-height: 100vh; padding: 16px; color: #111; }
.bar { display: flex; justify-content: space-between; max-width: 210mm; margin: 0 auto 10px; }
.err { color: #b91c1c; text-align: center; }
.sheet { background: #fff; max-width: 210mm; margin: 0 auto; padding: 14mm; font-size: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.15); }
header { display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 2px solid #111; padding-bottom: 8px; margin-bottom: 10px; }
h1 { margin: 0; font-size: 20px; letter-spacing: 1px; }
h2 { font-size: 13px; margin: 12px 0 6px; border-bottom: 1px solid #ccc; padding-bottom: 2px; }
.no { text-align: right; font-size: 14px; }
.muted { color: #666; font-size: 11px; }
.cols { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
dl { display: grid; grid-template-columns: 100px 1fr; gap: 3px 8px; margin: 0; }
dt { color: #555; }
dd { margin: 0; font-weight: 600; }
table { width: 100%; border-collapse: collapse; }
th, td { border-bottom: 1px solid #e5e7eb; padding: 4px 6px; text-align: left; }
.num { text-align: right; }
.strong td { font-weight: 700; border-top: 1px solid #111; }
.note, .pre { white-space: pre-wrap; margin: 4px 0; }
.sign { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; margin-top: 40px; }
.sign div { border-top: 1px solid #111; padding-top: 4px; text-align: center; }
@media print {
  .print-page { padding: 0; background: #fff; }
  .sheet { box-shadow: none; padding: 0; max-width: none; }
  @page { size: A4; margin: 12mm; }
}
@media (max-width: 600px) { .cols { grid-template-columns: 1fr; } .sheet { padding: 12px; } }
</style>
