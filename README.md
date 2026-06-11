# Lostify (Fien Lost)

A full-stack **lost & found platform** that helps users report, search, and recover lost items and identification cards. Users can post ads with photos and location details, browse listings, chat in real time, and manage their profile across web and mobile.

This repository is a **monorepo** containing three applications that share a common Django REST API backend.

| App | Folder | Platform |
|-----|--------|----------|
| Web frontend | `Lostify-Front-End/` | React + Vite |
| API backend | `Lostify-Back-End/` | Django REST Framework |
| Mobile app | `Lostify/` | Flutter |

---

## Architecture

```
┌─────────────────────┐     ┌─────────────────────┐
│  Lostify-Front-End  │     │      Lostify        │
│   (React / Vite)    │     │     (Flutter)       │
│   Port 5173         │     │   iOS / Android     │
└──────────┬──────────┘     └──────────┬──────────┘
           │  HTTPS / JWT               │  HTTPS / JWT
           │                            │
           └────────────┬───────────────┘
                        ▼
           ┌────────────────────────┐
           │   Lostify-Back-End   │
           │  Django REST API     │
           │  Port 8000 (dev)     │
           └──────────┬─────────────┘
                      │
           ┌──────────┴───────────┐
           │  SQLite (default)    │
           │  Media file uploads  │
           └──────────────────────┘

Mobile app additionally uses Supabase for real-time chat and image storage.
```

**Authentication:** JWT tokens via `djangorestframework-simplejwt`. Access tokens are stored in `localStorage` (web) or local cache (mobile).

**Key API resources:** users, item-types, ads, card-types, card-ads, chats, interactions, ratings.

---

## Tech Stack

### Frontend (`Lostify-Front-End/`)

- **React 18** + **TypeScript**
- **Vite 5** (dev server on port 5173)
- **Tailwind CSS** + **shadcn/ui** (Radix UI)
- **React Router**, **TanStack Query**, **React Hook Form**, **Zod**

### Backend (`Lostify-Back-End/`)

- **Python 3.12+**
- **Django 5.1.6** + **Django REST Framework 3.15**
- **SimpleJWT** for authentication
- **django-cors-headers**, **Pillow** (images), **Jazzmin** (admin UI)
- **SQLite** database (default, file: `db.sqlite3`)
- **Waitress** (production WSGI server, listed in requirements)

### Mobile (`Lostify/`)

- **Flutter 3.38+** / **Dart SDK ^3.6.0**
- **flutter_bloc** (state management), **Dio** + **http** (API client)
- **Supabase Flutter** (real-time chat & storage)
- **Google Maps**, **Geolocator**, **Google Generative AI** (image classification)
- **image_picker**, **Lottie** animations

---

## Prerequisites

| Tool | Version (tested) | Used by |
|------|------------------|---------|
| [Node.js](https://nodejs.org/) | 22.x | Frontend |
| npm | (bundled with Node) | Frontend |
| [Python](https://www.python.org/) | 3.12+ | Backend |
| [Flutter SDK](https://docs.flutter.dev/get-started/install) | 3.38+ | Mobile |
| Git | latest | All |

Optional: Android Studio / Xcode for mobile device builds; Postman for API testing (`Lostify-Back-End/POSTMAN_TESTING_GUIDE.md`).

---

## Getting Started

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd "Fien Lost"
```

> **Note:** Initialize git inside the `Fien Lost` folder if this is a new monorepo. The parent `Graduation Project 2025` directory may contain unrelated projects — use this folder as the git root.

### 2. Backend setup & run

```bash
cd Lostify-Back-End

# Create and activate virtual environment
python -m venv venv

# Windows
venv\Scripts\activate

# macOS / Linux
# source venv/bin/activate

pip install -r requirements.txt

# Copy environment template and set SECRET_KEY (required for production)
copy .env.example .env   # Windows
# cp .env.example .env   # macOS / Linux

# Run migrations and create admin user
python manage.py migrate
python manage.py createsuperuser

# Start development server
python manage.py runserver
```

The API is available at **http://127.0.0.1:8000/api/**  
Admin panel: **http://127.0.0.1:8000/admin/**

### 3. Frontend setup & run

```bash
cd Lostify-Front-End

npm install

# Configure API URL (defaults to localhost if omitted)
copy .env.example .env   # Windows
# cp .env.example .env   # macOS / Linux

npm run dev
```

The web app runs at **http://localhost:5173**

API requests use `VITE_API_BASE_URL` from `.env` via `src/lib/api.ts` (defaults to `http://127.0.0.1:8000/api/`).

### 4. Mobile app setup & run

```bash
cd Lostify

flutter pub get

# Copy secrets template and fill in real values (never commit dart_defines.json)
copy dart_defines.json.example dart_defines.json   # Windows
# cp dart_defines.json.example dart_defines.json   # macOS / Linux

# Google Maps: add GOOGLE_MAPS_API_KEY to android/local.properties
# (copy android/local.properties.example if you do not have local.properties yet)

# Run on connected device or emulator
flutter run --dart-define-from-file=dart_defines.json
```

For Android emulator, set `API_BASE_URL` to `http://10.0.2.2:8000/api/` in `dart_defines.json` (maps to host `localhost`).

See `Lostify/.env.example` and `Lostify/dart_defines.json.example` for all mobile variables.

---

## Environment Variables

Each project has an `.env.example` (or `dart_defines.json.example` for mobile) with placeholder values. Copy to `.env` / `dart_defines.json` and fill in real secrets. **Never commit secret files.**

### Backend (`Lostify-Back-End/.env.example`)

Loaded via `python-decouple` in `backend/settings.py`.

| Variable | Description | Default |
|----------|-------------|---------|
| `SECRET_KEY` | Django secret key | Dev-only placeholder |
| `DEBUG` | Debug mode | `True` |
| `ALLOWED_HOSTS` | Comma-separated hosts | `localhost,127.0.0.1` |
| `CORS_ALLOWED_ORIGINS` | Allowed frontend origins | `http://localhost:5173,...` |
| `CSRF_TRUSTED_ORIGINS` | Trusted CSRF origins | `http://localhost:5173,...` |
| `MEDIA_URL` | Public URL for uploaded media | `/media/` |

### Frontend (`Lostify-Front-End/.env.example`)

| Variable | Description | Default |
|----------|-------------|---------|
| `VITE_API_BASE_URL` | Backend API base URL | `http://127.0.0.1:8000/api/` |

Used by `src/lib/api.ts` (`apiUrl`, `mediaUrl`).

### Mobile (`Lostify/dart_defines.json.example`)

Passed via `flutter run --dart-define-from-file=dart_defines.json`. Read in `lib/core/config/env_config.dart`.

| Variable | Description | Default |
|----------|-------------|---------|
| `SUPABASE_URL` | Supabase project URL | (required) |
| `SUPABASE_ANON_KEY` | Supabase anonymous key | (required) |
| `API_BASE_URL` | Django API base URL | `http://127.0.0.1:8000/api/` |
| `GEMINI_API_KEY` | Google Gemini API key | (empty) |
| `GOOGLE_MAPS_API_KEY` | Google Maps API key | `android/local.properties` |

---

## API & Base URL Configuration

| Environment | Backend URL | Config location |
|-------------|-------------|-----------------|
| Local dev | `http://127.0.0.1:8000/api/` | Defaults in all apps |
| Android emulator | `http://10.0.2.2:8000/api/` | `API_BASE_URL` in `dart_defines.json` |
| Production | `https://your-domain.com:9443/api/` | `.env` / `dart_defines.json` |

**Frontend:** `VITE_API_BASE_URL` in `.env` → `src/lib/api.ts`

**Mobile:** `API_BASE_URL` in `dart_defines.json` → `lib/core/config/env_config.dart`

**Backend:** `ALLOWED_HOSTS`, `CORS_ALLOWED_ORIGINS`, `CSRF_TRUSTED_ORIGINS`, `MEDIA_URL` in `.env`

### Main API endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/register/` | User registration |
| POST | `/api/login/` | Login (returns JWT) |
| POST | `/api/token/` | Obtain JWT pair |
| POST | `/api/token/refresh/` | Refresh access token |
| GET/POST | `/api/ads/` | Lost/found item ads |
| GET/POST | `/api/card-ads/` | Lost/found card ads |
| GET | `/api/item-types/` | Item categories |
| GET | `/api/card-types/` | Card categories |
| GET/POST | `/api/chats/` | Chat messages |

---

## Folder Structure

```
Fien Lost/
├── README.md                 # This file
├── .gitignore                # Monorepo-wide ignore rules
├── logo.jpeg                 # Project logo
│
├── Lostify-Front-End/        # Web application
│   ├── .env.example
│   ├── package.json
│   ├── vite.config.ts
│   └── src/
│       ├── App.tsx           # Routes
│       ├── pages/            # Login, Register, Search, PostAd, Profile, etc.
│       └── components/       # UI components (shadcn)
│
├── Lostify-Back-End/         # Django API
│   ├── .env.example
│   ├── manage.py
│   ├── requirements.txt
│   ├── api/                  # Models, views, serializers, URLs
│   ├── backend/              # Django settings, WSGI
│   ├── static/               # Admin static assets
│   └── POSTMAN_TESTING_GUIDE.md
│
└── Lostify/                  # Flutter mobile app
    ├── .env.example
    ├── pubspec.yaml
    ├── lib/
    │   ├── main.dart         # Entry point (Supabase init)
    │   ├── features/         # Auth, search, chat, posts, profile
    │   └── core/             # DI, network, helpers
    ├── assets/               # Images, SVGs, Lottie files
    ├── android/
    └── ios/
```

---

## Common Issues & Troubleshooting

### CORS errors (frontend → backend)

Ensure `CORS_ALLOW_ALL_ORIGINS = True` (currently set) or add your frontend origin to `CORS_ALLOWED_ORIGINS` in `backend/settings.py`.

### Mobile cannot reach local backend

- Use `10.0.2.2` instead of `localhost` on Android emulator.
- Use your machine's LAN IP (e.g. `192.168.x.x`) on a physical device.
- Ensure Django runs with `python manage.py runserver 0.0.0.0:8000`.

### SSL / certificate errors with production URL

The production server uses HTTPS on port 9443. Local dev should use plain HTTP on port 8000.

### `ModuleNotFoundError` (Python)

Activate the virtual environment before running Django commands:

```bash
# Windows
Lostify-Back-End\venv\Scripts\activate
```

### Flutter build errors

```bash
flutter clean
flutter pub get
flutter run
```

### Images not loading

In development, set `MEDIA_URL = '/media/'` in settings and ensure `DEBUG = True` so Django serves media files.

### Database is empty

Run migrations and optionally load seed data:

```bash
python manage.py migrate
python manage.py createsuperuser
```

---

## Security Notes

- `.env`, `dart_defines.json`, `android/local.properties`, `venv/`, `node_modules/`, `db.sqlite3`, and `media/` are gitignored.
- Secrets are loaded from environment files — no production URLs or API keys in source code.
- Rotate any keys that were previously committed or shared publicly.
- For production, set `DEBUG = False`, use a strong `SECRET_KEY`, and restrict `ALLOWED_HOSTS`.

---

## License

Graduation project — © 2025 Egy Devs
