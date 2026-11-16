<script setup lang="ts">
import { ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useAuth } from '../stores/auth';

const auth = useAuth();
const router = useRouter();
const route = useRoute();
const username = ref('');
const password = ref('');
const error = ref('');
const busy = ref(false);

async function submit() {
  error.value = '';
  if (!username.value) return (error.value = 'Please enter username');
  if (!password.value) return (error.value = 'Please enter password');
  busy.value = true;
  try {
    await auth.login(username.value, password.value);
    const next = typeof route.query.next === 'string' && route.query.next.startsWith('/') ? route.query.next : '/';
    router.replace(next);
  } catch (e) {
    error.value = (e as Error).message;
  } finally {
    busy.value = false;
  }
}
</script>

<template>
  <div class="login-wrap">
    <form class="login card" @submit.prevent="submit">
      <img src="/icon-192.png" alt="" class="logo" />
      <h1>RentACar</h1>
      <div class="field">
        <label for="u">Username</label>
        <InputText id="u" v-model="username" autocomplete="username" autofocus />
      </div>
      <div class="field">
        <label for="p">Password</label>
        <InputText id="p" v-model="password" type="password" autocomplete="current-password" />
      </div>
      <Message v-if="error" severity="error" :closable="false">{{ error }}</Message>
      <Button type="submit" label="Log in" icon="pi pi-sign-in" :loading="busy" class="w-full" />
    </form>
  </div>
</template>

<style scoped>
.login-wrap { min-height: 100vh; display: grid; place-items: center; padding: 16px; background: linear-gradient(160deg, #1e3a8a, #0f172a); }
.login { width: 100%; max-width: 360px; display: flex; flex-direction: column; gap: 14px; padding: 28px; }
.login h1 { margin: 0; text-align: center; font-size: 1.5rem; }
.logo { width: 84px; height: 84px; margin: 0 auto; }
.w-full { width: 100%; }
</style>
