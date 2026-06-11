import os, sys
from pathlib import Path
BASE = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(BASE))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.settings')
from django.core.wsgi import get_wsgi_application
app = get_wsgi_application()
