import re

from django.core.exceptions import ValidationError


def validate_visa_card_number(value):
    digits = re.sub(r'\D', '', value)
    if len(digits) != 16:
        raise ValidationError('Visa card number must be 16 digits.')
    if not digits.startswith('4'):
        raise ValidationError('Visa card number must start with 4.')
    return digits


def validate_national_card_number(value):
    digits = re.sub(r'\D', '', value)
    if len(digits) != 14:
        raise ValidationError('National Card number must be exactly 14 digits.')
    return digits


def validate_other_card_number(value):
    if not re.match(r'^[a-zA-Z0-9]{1,30}$', value):
        raise ValidationError('Card number must be 1-30 alphanumeric characters.')
    return value


def validate_card_number(card_type_name, card_number):
    name = (card_type_name or '').strip().lower()
    if name == 'visa':
        return validate_visa_card_number(card_number)
    if name == 'national card':
        return validate_national_card_number(card_number)
    return validate_other_card_number(card_number)
