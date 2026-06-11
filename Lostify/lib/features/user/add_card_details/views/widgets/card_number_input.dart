import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lostify/core/helper/card_validation.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/add_card_details/models/card_type_model.dart';

class CardNumberInput extends StatelessWidget {
  const CardNumberInput({
    super.key,
    required this.controller,
    required this.cardType,
  });

  final TextEditingController controller;
  final CardTypeModel cardType;

  bool get _isVisa => cardType.name.toLowerCase() == 'visa';
  bool get _isNationalCard => cardType.name.toLowerCase() == 'national card';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isVisa ? 'Card ID *' : 'Ad Card Number *',
          style: AppTextStyles.title18PrimaryColorW500,
        ),
        SizedBox(height: context.screenHeight * 0.003),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            if (_isVisa)
              FilteringTextInputFormatter.allow(RegExp(r'[\d-]'))
            else if (_isNationalCard)
              FilteringTextInputFormatter.digitsOnly
            else
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
            if (_isVisa) LengthLimitingTextInputFormatter(19),
            if (_isNationalCard) LengthLimitingTextInputFormatter(14),
            if (!_isVisa && !_isNationalCard)
              LengthLimitingTextInputFormatter(30),
          ],
          onChanged: (value) {
            if (_isVisa) {
              final formatted = CardValidation.formatVisaInput(value);
              if (formatted != value) {
                controller.value = TextEditingValue(
                  text: formatted,
                  selection: TextSelection.collapsed(offset: formatted.length),
                );
              }
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Card number is required';
            }
            return CardValidation.validateForCardType(value, cardType.name);
          },
          decoration: InputDecoration(
            hintText: _isVisa
                ? 'XXXX-XXXX-XXXX-XXXX'
                : _isNationalCard
                    ? '14-digit national ID'
                    : 'Enter card number',
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.03,
              vertical: context.screenHeight * 0.016,
            ),
            hintStyle: AppTextStyles.title16Grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
