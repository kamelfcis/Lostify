# Generated manually for Lostify item type seed data

from django.db import migrations

ITEM_TYPES = [
    'Electronics',
    'Wallets',
    'Keys',
    'Documents',
    'Jewelry',
    'Bags',
    'Pets',
    'Others',
]

CARD_TYPES = [
    'Visa',
    'National Card',
    'Other',
]


def seed_item_and_card_types(apps, schema_editor):
    ItemType = apps.get_model('api', 'ItemType')
    CardType = apps.get_model('api', 'CardType')

    for name in ITEM_TYPES:
        ItemType.objects.get_or_create(name=name)

    for name in CARD_TYPES:
        CardType.objects.get_or_create(name=name)


def unseed_item_and_card_types(apps, schema_editor):
    ItemType = apps.get_model('api', 'ItemType')
    CardType = apps.get_model('api', 'CardType')

    ItemType.objects.filter(name__in=ITEM_TYPES).delete()
    CardType.objects.filter(name__in=CARD_TYPES).delete()


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0007_rename_card_name_to_card_number'),
    ]

    operations = [
        migrations.RunPython(seed_item_and_card_types, unseed_item_and_card_types),
    ]
