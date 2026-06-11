const DEFAULT_API_BASE_URL = 'http://127.0.0.1:8000/api/';

export const API_BASE_URL = (
  import.meta.env.VITE_API_BASE_URL ?? DEFAULT_API_BASE_URL
).replace(/\/?$/, '/');

export const MEDIA_BASE_URL = API_BASE_URL.replace(/\/api\/?$/, '');

export function apiUrl(path: string): string {
  const normalizedPath = path.startsWith('/') ? path.slice(1) : path;
  return `${API_BASE_URL}${normalizedPath}`;
}

export function mediaUrl(path: string): string {
  if (path.startsWith('http')) {
    return path;
  }
  return `${MEDIA_BASE_URL}${path}`;
}
