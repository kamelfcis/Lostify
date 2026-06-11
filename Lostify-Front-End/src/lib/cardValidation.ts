export function stripVisaDigits(value: string): string {
  return value.replace(/\D/g, '');
}

export function formatVisaInput(value: string): string {
  const digits = stripVisaDigits(value).slice(0, 16);
  const parts: string[] = [];
  for (let i = 0; i < digits.length; i += 4) {
    parts.push(digits.slice(i, i + 4));
  }
  return parts.join('-');
}

export function validateVisa(value: string): string | null {
  const digits = stripVisaDigits(value);
  if (digits.length !== 16) {
    return 'Visa card number must be 16 digits';
  }
  if (!digits.startsWith('4')) {
    return 'Visa card number must start with 4';
  }
  return null;
}

export function validateNationalCard(value: string): string | null {
  const digits = value.replace(/\D/g, '');
  if (digits.length !== 14) {
    return 'National Card number must be exactly 14 digits';
  }
  return null;
}

export function isNationalCardType(name: string | undefined): boolean {
  return name?.toLowerCase() === 'national card';
}

export function normalizeCardNumberForSubmit(
  value: string,
  cardTypeName: string | undefined
): string {
  const lower = cardTypeName?.toLowerCase() ?? '';
  if (lower === 'visa' || lower === 'national card') {
    return stripVisaDigits(value);
  }
  return value;
}
