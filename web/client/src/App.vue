<script setup lang="ts">
import { computed, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useRegisterSW } from 'virtual:pwa-register/vue';
import { useAuth, type Permission } from './stores/auth';

const auth = useAuth();
const route = useRoute();
const router = useRouter();
const menuOpen = ref(false);
const online = ref(navigator.onLine);
window.addEventListener('online', () => (online.value = true));
window.addEventListener('offline', () => (online.value = false));

const { needRefresh, updateServiceWorker } = useRegisterSW();

const nav: { to: string; label: string; icon: string; perm?: Permission }[] = [
  { to: '/', label: 'Home', icon: 'pi pi-home' },
  { to: '/timetable', label: 'Time Table', icon: 'pi pi-calendar', perm: 'timetable' },
  { to: '/reservations', label: 'Reservations', icon: 'pi pi-book' },
  { to: '/customers', label: 'Customers', icon: 'pi pi-users' },
  { to: '/cars', label: 'Cars', icon: 'pi pi-car' },
  { to: '/transfers', label: 'Transfers', icon: 'pi pi-send' },
  { to: '/agencies', label: 'Agencies', icon: 'pi pi-briefcase' },
  { to: '/rates', label: 'Exchange Rates', icon: 'pi pi-pound' },
  { to: '/reports', label: 'Reports', icon: 'pi pi-chart-bar', perm: 'reports' },
  { to: '/companies', label: 'Companies', icon: 'pi pi-building', perm: 'admin' },
  { to: '/places', label: 'Places', icon: 'pi pi-map-marker', perm: 'admin' },
  { to: '/users', label: 'Users', icon: 'pi pi-lock', perm: 'admin' },
];
const items = computed(() => nav.filter((n) => !n.perm || auth.can(n.perm)));
const isActive = (to: string) => (to === '/' ? route.path === '/' : route.path.startsWith(to));
watch(() => route.fullPath, () => (menuOpen.value = false));

const dark = ref(localStorageGet('dark') === '1' || (localStorageGet('dark') === null && matchMedia('(prefers-color-scheme: dark)').matches));
watch(dark, (v) => {
  document.documentElement.classList.toggle('app-dark', v);
  localStorageSet('dark', v ? '1' : '0');
}, { immediate: true });

function localStorageGet(k: string) { try { return localStorage.getItem(k); } catch { return null; } }
function localStorageSet(k: string, v: string) { try { localStorage.setItem(k, v); } catch { /* ignore */ } }

async function logout() {
  await auth.logout();
  router.push('/login');
}
</script>

<template>
  <Toast position="top-right" />
  <ConfirmDialog style="max-width: 92vw; white-space: pre-line" />

  <RouterView v-if="route.meta.bare" />

  <div v-else class="shell">
    <header class="topbar no-print">
      <button class="icon-btn menu-toggle" aria-label="Menu" @click="menuOpen = !menuOpen"><i class="pi pi-bars" /></button>
      <RouterLink to="/" class="brand"><img src="/favicon.png" alt="" /> RentACar</RouterLink>
      <span v-if="!online" class="offline"><i class="pi pi-wifi" /> Offline – read only</span>
      <span class="spacer" />
      <button class="icon-btn" :aria-label="dark ? 'Light mode' : 'Dark mode'" @click="dark = !dark"><i :class="dark ? 'pi pi-sun' : 'pi pi-moon'" /></button>
      <span class="user"><i class="pi pi-user" /> {{ auth.user?.username }}</span>
      <button class="icon-btn" aria-label="Log out" title="Log out" @click="logout"><i class="pi pi-sign-out" /></button>
    </header>

    <nav class="sidebar no-print" :class="{ open: menuOpen }">
      <RouterLink v-for="n in items" :key="n.to" :to="n.to" class="nav-item" :class="{ active: isActive(n.to) }">
        <i :class="n.icon" /> <span>{{ n.label }}</span>
      </RouterLink>
    </nav>
    <div v-if="menuOpen" class="backdrop no-print" @click="menuOpen = false" />

    <main class="content">
      <div v-if="needRefresh" class="update-bar no-print">
        A new version is available.
        <Button size="small" label="Update" @click="updateServiceWorker(true)" />
      </div>
      <RouterView :key="route.path" />
    </main>
  </div>
</template>

<style scoped>
.shell { min-height: 100vh; }
.topbar {
  position: sticky; top: 0; z-index: 30; height: 52px; display: flex; align-items: center; gap: 10px;
  padding: 0 12px; background: var(--app-nav); color: #fff;
}
.brand { display: flex; align-items: center; gap: 8px; font-weight: 700; text-decoration: none; color: #fff; font-size: 1.05rem; }
.brand img { width: 28px; height: 28px; }
.spacer { flex: 1; }
.user { font-size: 13px; opacity: 0.9; white-space: nowrap; }
.offline { background: #f59e0b; color: #111; border-radius: 6px; padding: 2px 8px; font-size: 12px; }
.icon-btn { background: transparent; border: 0; color: #fff; width: 36px; height: 36px; border-radius: 8px; cursor: pointer; font-size: 1.05rem; }
.icon-btn:hover { background: rgba(255,255,255,0.12); }
.menu-toggle { display: none; }
.sidebar {
  position: fixed; top: 52px; bottom: 0; left: 0; width: 210px; overflow-y: auto; padding: 8px;
  background: var(--app-surface); border-right: 1px solid var(--app-border); z-index: 25;
}
.nav-item {
  display: flex; align-items: center; gap: 10px; padding: 9px 12px; border-radius: 8px; text-decoration: none;
  color: var(--app-text); font-weight: 500; margin-bottom: 2px;
}
.nav-item:hover { background: var(--app-bg); }
.nav-item.active { background: var(--app-nav-active); color: #fff; }
.content { margin-left: 210px; min-width: 0; }
.update-bar { display: flex; gap: 10px; align-items: center; justify-content: center; padding: 8px; background: #fef3c7; color: #111; }
.backdrop { display: none; }
@media (max-width: 900px) {
  .menu-toggle { display: inline-block; }
  .sidebar { transform: translateX(-100%); transition: transform 0.2s; box-shadow: 0 0 20px rgba(0,0,0,0.2); }
  .sidebar.open { transform: none; }
  .content { margin-left: 0; }
  .backdrop { display: block; position: fixed; inset: 52px 0 0 0; background: rgba(0,0,0,0.3); z-index: 20; }
  .user { display: none; }
}
@media print { .content { margin: 0; } }
</style>
