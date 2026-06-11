# Remove legacy item types so only the canonical eight remain.

from django.db import migrations

CANONICAL_ITEM_TYPES = [
    'Electronics',
    'Wallets',
    'Keys',
    'Documents',
    'Jewelry',
    'Bags',
    'Pets',
    'Others',
]


def cleanup_item_types(apps, schema_editor):
    ItemType = apps.get_model('api', 'ItemType')
    ItemType.objects.exclude(name__in=CANONICAL_ITEM_TYPES).delete()

    for name in CANONICAL_ITEM_TYPES:
        ItemType.objects.get_or_create(name=name)


def noop_reverse(apps, schema_editor):
    pass


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_seed_item_types'),
    ]

    operations = [
        migrations.RunPython(cleanup_item_types, noop_reverse),
    ]
