<script setup lang="ts">
import { ref } from 'vue';
import { api, qs } from '../lib/api';
import { useUi } from '../lib/ui';

/** Search box for customers; emits the chosen customer row. */
const emit = defineEmits<{ select: [customer: any] }>();
const props = defineProps<{ disabled?: boolean; allowCreate?: boolean }>();
const ui = useUi();
const query = ref<any>('');
const suggestions = ref<any[]>([]);

async function search(e: { query: string }) {
  try {
    suggestions.value = await api.get(`/api/customers${qs({ search: e.query, limit: 30 })}`);
  } catch (err) {
    ui.error(err);
  }
}
function pick(e: { value: any }) {
  emit('select', e.value);
  query.value = '';
}

// Quick "new customer" (Delphi: New Entry mode on the reservation screen)
const show = ref(false);
const nc = ref({ Name: '', Surname: '', TelNo: '', PassportId: '', LicenseNo: '', Email: '', PlaceofBirth: '' });
async function create() {
  try {
    const { id } = await api.post('/api/customers', nc.value);
    emit('select', { id, ...nc.value });
    show.value = false;
    nc.value = { Name: '', Surname: '', TelNo: '', PassportId: '', LicenseNo: '', Email: '', PlaceofBirth: '' };
    ui.ok('Customer saved');
  } catch (e) {
    ui.error(e);
  }
}
</script>

<template>
  <div class="row picker">
    <AutoComplete v-model="query" :suggestions="suggestions" :disabled="props.disabled" placeholder="Search customer (name, passport, phone)…"
      class="grow" input-class="w-full" :delay="250" :min-length="2" @complete="search" @option-select="pick">
      <template #option="{ option }">
        <div>
          <b>{{ option.Name }} {{ option.Surname }}</b>
          <Tag v-if="option.BlackList === 'Y'" value="BLACK LIST" severity="danger" class="ml" />
          <div class="muted small">{{ option.PassportId }} {{ option.TelNo || option.LocalNumber }}</div>
        </div>
      </template>
    </AutoComplete>
    <Button v-if="allowCreate" icon="pi pi-user-plus" outlined :disabled="props.disabled" v-tooltip.top="'New customer'" aria-label="New customer" @click="show = true" />
  </div>
  <Dialog v-model:visible="show" modal header="New customer" style="width: 520px; max-width: 95vw">
    <div class="grid">
      <div class="field"><label>Name *</label><InputText v-model="nc.Name" /></div>
      <div class="field"><label>Surname *</label><InputText v-model="nc.Surname" /></div>
      <div class="field"><label>Phone</label><InputText v-model="nc.TelNo" /></div>
      <div class="field"><label>Passport / ID</label><InputText v-model="nc.PassportId" /></div>
      <div class="field"><label>Driving licence</label><InputText v-model="nc.LicenseNo" /></div>
      <div class="field"><label>Place of birth</label><InputText v-model="nc.PlaceofBirth" /></div>
      <div class="field full"><label>E-mail</label><InputText v-model="nc.Email" type="email" /></div>
    </div>
    <template #footer>
      <Button label="Cancel" text @click="show = false" />
      <Button label="Save customer" icon="pi pi-check" :disabled="!nc.Name || !nc.Surname" @click="create" />
    </template>
  </Dialog>
</template>

<style scoped>
.picker { flex-wrap: nowrap; }
.grow { flex: 1; min-width: 0; }
.grow :deep(input) { width: 100%; }
.small { font-size: 12px; }
.ml { margin-left: 6px; }
</style>
