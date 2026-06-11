import 'package:flutter/cupertino.dart';
import 'package:lostify/core/components/custom_text_form_field_with_title.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/auth/sign_in/models/user_model.dart';

class UpdateProfileForm extends StatelessWidget {
  const UpdateProfileForm({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFieldWithTitle(
          hintText: user?.username ?? '',
          title: 'User Name',
          enable: false,
        ),
        SizedBox(height: SizeConfig.height * 0.015),
        CustomTextFormFieldWithTitle(
          hintText: '21/07/2002',
          title: 'Date Of Birth',
          enable: false,
        ),
        SizedBox(height: SizeConfig.height * 0.015),
        CustomTextFormFieldWithTitle(
          hintText: '${user?.username}@gmail.com',
          title: 'Email Address',
          enable: false,
        ),
        SizedBox(height: SizeConfig.height * 0.015),
        CustomTextFormFieldWithTitle(
          hintText: '+20 1225084331',
          title: 'Phone Number',
          enable: false,
        ),
      ],
    );
  }
}

