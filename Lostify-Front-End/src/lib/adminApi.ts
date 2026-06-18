import { apiUrl } from './api';

function getToken(): string {
  return localStorage.getItem('accessToken') ?? '';
}

function authHeaders(): HeadersInit {
  return {
    'Content-Type': 'application/json',
    Authorization: `Bearer ${getToken()}`,
  };
}

export function decodeJwt(token: string): Record<string, unknown> {
  try {
    const payload = token.split('.')[1];
    return JSON.parse(atob(payload));
  } catch {
    return {};
  }
}

export function isAdminUser(): boolean {
  const token = getToken();
  if (!token) return false;
  const payload = decodeJwt(token);
  if (payload.is_superuser === true) return true;

  // Also check localStorage user object as fallback
  try {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      const user = JSON.parse(storedUser);
      return user.is_superuser === true;
    }
  } catch {
    // ignore
  }
  return false;
}

export function getAdminUsername(): string {
  try {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      return JSON.parse(storedUser).username ?? 'Admin';
    }
  } catch {
    // ignore
  }
  const token = getToken();
  if (token) {
    const payload = decodeJwt(token);
    return (payload.username as string) ?? 'Admin';
  }
  return 'Admin';
}

// Generic fetch helpers
export async function adminGet<T>(path: string): Promise<T> {
  const res = await fetch(apiUrl(path), { headers: authHeaders() });
  if (!res.ok) throw new Error(`GET ${path} failed: ${res.status}`);
  return res.json() as Promise<T>;
}

export async function adminDelete(path: string): Promise<void> {
  const res = await fetch(apiUrl(path), {
    method: 'DELETE',
    headers: authHeaders(),
  });
  if (!res.ok) throw new Error(`DELETE ${path} failed: ${res.status}`);
}

export async function adminPost<T>(path: string, body: unknown): Promise<T> {
  const res = await fetch(apiUrl(path), {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify(body),
  });
  if (!res.ok) throw new Error(`POST ${path} failed: ${res.status}`);
  return res.json() as Promise<T>;
}
