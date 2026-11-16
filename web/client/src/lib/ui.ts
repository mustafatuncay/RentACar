import { useConfirm } from 'primevue/useconfirm';
import { useToast } from 'primevue/usetoast';
import { ApiError } from './api';

/** Toast + confirm helpers used by every screen. */
export function useUi() {
  const toast = useToast();
  const confirm = useConfirm();

  const ok = (summary: string) => toast.add({ severity: 'success', summary, life: 2500 });
  const error = (e: unknown) => {
    const err = e as ApiError;
    let detail = err?.message ?? String(e);
    if (err?.details?.code === 'DOUBLE_BOOKING' && err.details.clash) {
      const c = err.details.clash;
      detail = `Double booking with reservation #${c.id} (${c.customer}) ${c.from} - ${c.to}`;
    }
    toast.add({ severity: 'error', summary: 'Error', detail, life: 7000 });
  };
  const ask = (message: string, header = 'Please confirm', danger = false) =>
    new Promise<boolean>((resolve) =>
      confirm.require({
        message,
        header,
        icon: danger ? 'pi pi-exclamation-triangle' : 'pi pi-question-circle',
        rejectProps: { label: 'No', severity: 'secondary', outlined: true },
        acceptProps: { label: 'Yes', severity: danger ? 'danger' : 'primary' },
        accept: () => resolve(true),
        reject: () => resolve(false),
        onHide: () => resolve(false),
      }),
    );

  /** Runs a save; if the server answers "customer is on the black list", asks and retries. */
  async function saveWithBlacklist<T>(fn: (confirmBlacklist: boolean) => Promise<T>): Promise<T | undefined> {
    try {
      return await fn(false);
    } catch (e) {
      const err = e as ApiError;
      if (err.status === 409 && err.details?.code === 'BLACKLIST') {
        const note = err.details.note ? `\nNote: ${err.details.note}` : '';
        if (await ask(`The customer you chose is on the BLACK LIST!${note}\nDo you want to continue?`, 'Black list', true)) {
          return fn(true);
        }
        return undefined;
      }
      throw e;
    }
  }

  return { ok, error, ask, saveWithBlacklist, toast };
}
