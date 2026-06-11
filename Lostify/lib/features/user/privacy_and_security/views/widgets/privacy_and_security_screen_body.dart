import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/home/views/widgets/custom_gradient_body.dart';
import 'package:lostify/features/user/privacy_and_security/views/widgets/app_logo.dart';
import 'package:lostify/features/user/privacy_and_security/views/widgets/info_tile.dart';
import 'package:lostify/features/user/privacy_and_security/views/widgets/section_card.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class PrivacyAndSecurityScreenBody extends StatelessWidget {
  const PrivacyAndSecurityScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGradientBody(
      child: Column(
        children: [
          CustomHeader(
            title: "Privacy & Security",
            icon: Icons.lock_outline,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.05,
                vertical: SizeConfig.height * 0.02,
              ),
              child: Column(
                children: [
                  AppLogo(),
                  SizedBox(height: SizeConfig.height * 0.03),
                  SectionCard(
                    title: 'Your Privacy Matters',
                    description:
                        'We are committed to protecting your personal data and ensuring your information is secure.',
                  ),
                  SizedBox(height: SizeConfig.height * 0.02),
                  InfoTile(
                    icon: Icons.lock_outline,
                    title: 'Data Protection',
                    subtitle: 'Your data is encrypted and securely stored.',
                  ),
                  InfoTile(
                    icon: Icons.visibility_off_outlined,
                    title: 'Privacy Control',
                    subtitle: 'You control what information is shared.',
                  ),
                  InfoTile(
                    icon: Icons.security_outlined,
                    title: 'Account Security',
                    subtitle: 'We use industry-standard security practices.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


