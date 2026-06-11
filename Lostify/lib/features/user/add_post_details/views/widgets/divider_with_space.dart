import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class DividerWithSpace extends StatelessWidget {
  const DividerWithSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.height * 0.01),
        Divider(thickness: 1, color: Colors.grey.shade300),
        SizedBox(height: SizeConfig.height * 0.01),
      ],
    );
  }
}
