import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class OrWithDivider extends StatelessWidget {
  const OrWithDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.height * 0.005,
      ),
      child: Row(
        children: [
          Expanded(child: Divider()),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.01,
            ),
            child: Text("Or"),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}
