import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/my_account/views/widgets/account_header.dart';
import 'package:lostify/features/user/my_account/views/widgets/account_info_card.dart';
import 'package:lostify/features/user/my_account/views/widgets/update_account_form.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class MyAccountScreenBody extends StatelessWidget {
  const MyAccountScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt<CacheHelper>().getUserModel();

    return Column(
      children: [
        CustomHeader(
          title: "My Account",
          icon: Icons.person,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.05,
              vertical: SizeConfig.height * 0.02,
            ),
            child: Column(
              children: [
                AccountHeader(username: user?.username),
                SizedBox(height: SizeConfig.height * 0.03),
                AccountInfoCard(
                  child: UpdateProfileForm(user: user),
                ),
                SizedBox(height: SizeConfig.height * 0.04),
                CustomElevatedButton(
                  name: 'Update Profile',
                  onPressed: () {},
                  backgroundColor: AppColors.kPrimaryColor,
                  textStyle: AppTextStyles.title20WhiteBold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

