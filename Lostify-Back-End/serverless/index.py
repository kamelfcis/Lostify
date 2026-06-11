import os
import sys
from pathlib import Path

BASE = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(BASE))

if os.environ.get('VERCEL') and not os.environ.get('TURSO_DATABASE_URL'):
    os.environ.setdefault('DJANGO_DB_PATH', '/tmp/db.sqlite3')

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.settings')

import django

django.setup()

from django.core.management import call_command

call_command('migrate', '--noinput', verbosity=0)

from django.core.wsgi import get_wsgi_application

app = get_wsgi_application()
