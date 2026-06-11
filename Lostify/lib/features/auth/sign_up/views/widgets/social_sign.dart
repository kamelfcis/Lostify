import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/auth/sign_up/views/widgets/custom_social_button.dart';

class SocialSign extends StatelessWidget {
  const SocialSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSocialButton(
          icon: Icons.apple,
          onPressed: () {},
        ),
        SizedBox(width: SizeConfig.width * 0.06),
        CustomSocialButton(
          icon: Icons.facebook,
          onPressed: () {},
        ),
        SizedBox(width: SizeConfig.width * 0.06),
        CustomSocialButton(
          icon: Icons.email,
          onPressed: () {},
        ),
      ],
    );
  }
}

