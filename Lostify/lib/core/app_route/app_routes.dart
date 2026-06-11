import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/features/auth/sign_in/views/screens/sign_in_screen.dart';
import 'package:lostify/features/auth/sign_up/views/screens/sign_up_screen.dart';
import 'package:lostify/features/chat/views/screens/chat_screen.dart';
import 'package:lostify/features/on_boarding/views/screens/on_boarding_screen.dart';
import 'package:lostify/features/splash/views/screens/splash_screen.dart';
import 'package:lostify/features/user/add_card_details/views/screens/add_card_details_screen.dart';
import 'package:lostify/features/user/add_post/views/screens/add_post_screen.dart';
import 'package:lostify/features/user/add_post_details/view_models/cubit/add_post_cubit.dart';
import 'package:lostify/features/user/add_post_details/views/screens/add_post_details_screen.dart';
import 'package:lostify/features/user/card_type/views/screens/card_type_screen.dart';
import 'package:lostify/features/user/item_type/views/screens/categories_screen.dart';
import 'package:lostify/features/user/filter/views/screens/filter_screen.dart';
import 'package:lostify/features/user/help_and_support/views/screens/help_and_support_screen.dart';
import 'package:lostify/features/user/home/view_models/cubit/bottom_nav_bar_cubit.dart';
import 'package:lostify/features/user/home/views/screens/home_screen.dart';
import 'package:lostify/features/user/my_account/views/screens/my_account_screen.dart';
import 'package:lostify/features/user/item_details/views/screens/item_details_screen.dart';
import 'package:lostify/features/user/privacy_and_security/views/screens/privacy_and_security_screen.dart';
import 'package:lostify/features/user/search/views/screens/search_screen.dart';
import 'package:lostify/features/user/select_item_type/view_models/cubit/item_types_cubit.dart';
import 'package:lostify/features/user/select_item_type/views/screens/select_item_type_screen.dart';
import 'package:lostify/features/user/select_upload_image_type/view_models/cubit/select_upload_image_type_cubit.dart';
import 'package:lostify/features/user/select_upload_image_type/views/screens/select_upload_image_type_screen.dart';
import 'package:lostify/features/user/upload_image/views/screens/upload_image_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onBoardingScreen: (context) => const OnBoardingScreen(),
    RouteNames.signInScreen: (context) => const SignInScreen(),
    RouteNames.signUpScreen: (context) => const SignUpScreen(),
    RouteNames.homeScreen: (context) => BlocProvider(
          create: (context) => BottomNavBarCubit(),
          child: HomeScreen(),
        ),
    RouteNames.uploadImageScreen: (context) => const UploadImageScreen(),
    RouteNames.selectUploadImageTypeScreen: (context) => BlocProvider(
          create: (context) => SelectUploadImageTypeCubit(),
          child: const SelectUploadImageTypeScreen(),
        ),
    RouteNames.searchScreen: (context) => const SearchScreen(),
    RouteNames.addItemScreen: (context) => const AddItemScreen(),
    RouteNames.selectItemTypeScreen: (context) => BlocProvider(
          create: (context) =>
              ItemTypesCubit(apiConsumer: getIt<ApiConsumer>()),
          child: const SelectItemTypeScreen(),
        ),
    RouteNames.addPostDetailsScreen: (context) => BlocProvider(
          create: (context) => AddPostCubit(apiConsumer: getIt<ApiConsumer>()),
          child: const AddPostDetailsScreen(),
        ),
    RouteNames.addCardDetailsScreen: (context) => const AddCardDetailsScreen(),
    RouteNames.postDetailsScreen: (context) => const ItemDetailsScreen(),
    RouteNames.chatScreen: (context) => const ChatScreen(),
    RouteNames.myAccountScreen: (context) => const MyAccountScreen(),
    RouteNames.filterScreen: (context) => const FilterScreen(),
    RouteNames.categoriesScreen: (context) => const CategoriesScreen(),
    RouteNames.helpAndSupportScreen: (context) => const HelpAndSupportScreen(),
    RouteNames.privacyAndSecurityScreen: (context) =>
        const PrivacyAndSecurityScreen(),
    RouteNames.cardTypeScreen: (context) => const CardTypeScreen(),
  };
}
