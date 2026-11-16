import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router';
import { useAuth, type Permission } from './stores/auth';
import { setUnauthorizedHandler } from './lib/api';

declare module 'vue-router' {
  interface RouteMeta { public?: boolean; perm?: Permission; title?: string; bare?: boolean }
}

const routes: RouteRecordRaw[] = [
  { path: '/login', component: () => import('./views/LoginView.vue'), meta: { public: true, bare: true, title: 'Login' } },
  { path: '/', component: () => import('./views/DashboardView.vue'), meta: { title: 'Home' } },
  { path: '/timetable', component: () => import('./views/TimeTableView.vue'), meta: { perm: 'timetable', title: 'Time Table' } },
  { path: '/reservations', component: () => import('./views/ReservationsView.vue'), meta: { title: 'Reservations' } },
  { path: '/reservations/new', component: () => import('./views/ReservationFormView.vue'), meta: { perm: 'timetable', title: 'New Reservation' } },
  { path: '/reservations/:id', component: () => import('./views/ReservationFormView.vue'), meta: { title: 'Reservation' } },
  { path: '/reservations/:id/print', component: () => import('./views/ReservationPrintView.vue'), meta: { bare: true, title: 'Print' } },
  { path: '/cars', component: () => import('./views/CarsView.vue'), meta: { title: 'Cars' } },
  { path: '/cars/:id', component: () => import('./views/CarDetailView.vue'), meta: { title: 'Car' } },
  { path: '/customers', component: () => import('./views/CustomersView.vue'), meta: { title: 'Customers' } },
  { path: '/customers/:id', component: () => import('./views/CustomerFormView.vue'), meta: { title: 'Customer' } },
  { path: '/transfers', component: () => import('./views/TransfersView.vue'), meta: { title: 'Transfers' } },
  { path: '/transfers/:id', component: () => import('./views/TransferFormView.vue'), meta: { title: 'Transfer' } },
  { path: '/agencies', component: () => import('./views/NameListView.vue'), props: { kind: 'agencies' }, meta: { title: 'Agencies' } },
  { path: '/companies', component: () => import('./views/NameListView.vue'), props: { kind: 'companies' }, meta: { title: 'Companies' } },
  { path: '/places', component: () => import('./views/PlacesView.vue'), meta: { title: 'Places' } },
  { path: '/rates', component: () => import('./views/KurView.vue'), meta: { title: 'Exchange Rates' } },
  { path: '/reports', component: () => import('./views/ReportsView.vue'), meta: { perm: 'reports', title: 'Reports' } },
  { path: '/users', component: () => import('./views/UsersView.vue'), meta: { perm: 'admin', title: 'Users' } },
  { path: '/:pathMatch(.*)*', redirect: '/' },
];

export const router = createRouter({ history: createWebHistory(), routes });

router.beforeEach(async (to) => {
  const auth = useAuth();
  if (!auth.checked) await auth.check();
  if (to.meta.public) return true;
  if (!auth.user) return { path: '/login', query: to.fullPath !== '/' ? { next: to.fullPath } : {} };
  if (to.meta.perm && !auth.can(to.meta.perm)) return '/';
  return true;
});

router.afterEach((to) => {
  document.title = to.meta.title ? `${to.meta.title} · RentACar` : 'RentACar';
});

setUnauthorizedHandler(() => {
  const auth = useAuth();
  auth.user = null;
  if (router.currentRoute.value.path !== '/login') router.push({ path: '/login', query: { next: router.currentRoute.value.fullPath } });
});
