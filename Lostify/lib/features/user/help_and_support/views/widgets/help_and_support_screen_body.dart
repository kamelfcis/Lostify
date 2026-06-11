import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/home/views/widgets/custom_gradient_body.dart';
import 'package:lostify/features/user/privacy_and_security/views/widgets/app_logo.dart';
import 'package:lostify/features/user/privacy_and_security/views/widgets/info_tile.dart';
import 'package:lostify/features/user/privacy_and_security/views/widgets/section_card.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class HelpAndSupportScreenBody extends StatelessWidget {
  const HelpAndSupportScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGradientBody(
      child: Column(
        children: [
          CustomHeader(
            title: "Help & Support",
            icon: Icons.help_outline,
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
                    title: 'Need Help?',
                    description:
                        'We are here to help you. Find answers to common questions or contact support.',
                  ),
                  SizedBox(height: SizeConfig.height * 0.02),
                  InfoTile(
                    icon: Icons.help_outline,
                    title: 'FAQs',
                    subtitle: 'Find answers to common questions.',
                  ),
                  InfoTile(
                    icon: Icons.support_agent_outlined,
                    title: 'Contact Support',
                    subtitle: 'Reach out to our support team.',
                  ),
                  InfoTile(
                    icon: Icons.email_outlined,
                    title: 'Email Us',
                    subtitle: 'support@lostify.com',
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
