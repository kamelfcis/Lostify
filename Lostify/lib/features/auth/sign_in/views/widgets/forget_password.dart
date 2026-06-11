import 'package:lostify/core/components/custom_text_button.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextButton(
          title: "Forget Password?",
          onPressed: () {},
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}
