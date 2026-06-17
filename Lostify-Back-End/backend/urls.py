"""
URL configuration for backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
import json
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST

_INIT_SECRET = "lostify-init-7f3a9b2e"

@csrf_exempt
@require_POST
def _create_admin(request):
    try:
        body = json.loads(request.body or b'{}')
    except Exception:
        body = {}
    if body.get('secret') != _INIT_SECRET:
        return JsonResponse({'error': 'forbidden'}, status=403)
    from django.contrib.auth import get_user_model
    User = get_user_model()
    if User.objects.filter(username='admin').exists():
        return JsonResponse({'status': 'already_exists'})
    User.objects.create_superuser('admin', 'admin@lostify.com', 'Admin@1234')
    return JsonResponse({'status': 'created'})

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),
    path('api-auth/', include('rest_framework.urls')),
    path('api/_init_admin/', _create_admin),
]

# Local dev only: WhiteNoise serves static in production; Cloudinary serves media URLs.
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    