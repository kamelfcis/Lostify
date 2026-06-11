import google.generativeai as genai
from django.conf import settings

from .models import ItemType


def _build_prompt(category_names):
    return f"""This image belongs to which of the following categories?
{', '.join(category_names)}
Answer with the category name only without any additions.
If the image doesn't belong to any category, answer with "Unknown".
"""


def _match_category(raw_answer, category_names):
    answer = (raw_answer or '').strip()
    if not answer or answer.lower() == 'unknown':
        return None

    for name in category_names:
        if name.lower() == answer.lower():
            return name
    return None


def classify_image(image_bytes, mime_type='image/jpeg'):
    api_key = settings.GEMINI_API_KEY
    if not api_key:
        raise RuntimeError('GEMINI_API_KEY is not configured.')

    category_names = list(ItemType.objects.values_list('name', flat=True))
    if not category_names:
        raise RuntimeError('No item categories are configured.')

    genai.configure(api_key=api_key)
    model = genai.GenerativeModel('gemini-2.5-flash')

    response = model.generate_content([
        _build_prompt(category_names),
        {'mime_type': mime_type or 'image/jpeg', 'data': image_bytes},
    ])

    raw_answer = ''
    if response.candidates:
        raw_answer = (response.candidates[0].content.parts[0].text or '').strip()

    category = _match_category(raw_answer, category_names)
    if not category:
        raise ValueError('Could not classify image into a known category.')
    return category
