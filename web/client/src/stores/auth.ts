import { defineStore } from 'pinia';
import { api } from '../lib/api';

export type Permission = 'cars' | 'timetable' | 'customers' | 'reports' | 'transfers' | 'admin' | 'agency';
export interface User { id: number; username: string; perms: Permission[] }

export const useAuth = defineStore('auth', {
  state: () => ({ user: null as User | null, checked: false }),
  getters: {
    can: (s) => (p: Permission) => !!s.user?.perms.includes(p),
  },
  actions: {
    async check() {
      try {
        this.user = (await api.get<{ user: User }>('/api/auth/me')).user;
      } catch {
        this.user = null;
      }
      this.checked = true;
      return this.user;
    },
    async login(username: string, password: string) {
      this.user = (await api.post<{ user: User }>('/api/auth/login', { username, password })).user;
    },
    async logout() {
      await api.post('/api/auth/logout').catch(() => {});
      this.user = null;
    },
  },
});
