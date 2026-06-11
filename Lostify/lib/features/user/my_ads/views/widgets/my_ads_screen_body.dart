import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/my_ads/view_models/cubit/my_ads_cubit.dart';
import 'package:lostify/features/user/my_ads/views/widgets/custom_failure_message.dart';
import 'package:lostify/features/user/my_ads/views/widgets/my_ads_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/custom_loading_indicator.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class MyAdsScreenBody extends StatelessWidget {
  const MyAdsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(title: "My Ads", icon: Icons.list),
        SizedBox(height: SizeConfig.height * 0.01),
        Expanded(
          child: BlocBuilder<MyAdsCubit, MyAdsState>(
            builder: (context, state) {
              if (state is GetMyAdsLoading) {
                return CustomLoadingIndicator();
              }
              if (state is GetMyAdsError) {
                return CustomFailureMesage(errorMessage: state.message);
              }
              return MyAdsListView();
            },
          ),
        ),
      ],
    );
  }
}

