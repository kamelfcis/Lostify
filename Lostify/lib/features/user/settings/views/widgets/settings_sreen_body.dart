import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/settings/views/widgets/settings_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var settingsItems = AppConstants.settingsItems;
    return Column(
      children: [
        CustomHeader(title: "Settings", icon: Icons.settings),        
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.02,
            ),
            child: GridView.builder(
              itemCount: settingsItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: SizeConfig.height * 0.02,
                crossAxisSpacing: SizeConfig.width * 0.03,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final item = settingsItems[index];
                return SettingsGridItem(
                  icon: item.icon,
                  title: item.title,
                  onTap: item.onTap,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
