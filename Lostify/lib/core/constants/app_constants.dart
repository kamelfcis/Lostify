import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/app/my_app.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/utilies/assets/lotties/app_lotties.dart';
import 'package:lostify/features/on_boarding/models/on_boarding_step_model.dart';
import 'package:lostify/features/user/home/models/bottom_nav_item_model.dart';
import 'package:lostify/features/user/items/views/widgets/items_screen_body.dart';
import 'package:lostify/features/user/my_ads/view_models/cubit/my_ads_cubit.dart';
import 'package:lostify/features/user/my_ads/views/widgets/my_ads_screen_body.dart';
import 'package:lostify/features/user/my_chats/view_models/cubit/my_chats_cubit.dart';
import 'package:lostify/features/user/my_chats/views/widgets/my_chats_screen_body.dart';
import 'package:lostify/features/user/settings/models/settings_item_model.dart';
import 'package:lostify/features/user/settings/views/widgets/settings_sreen_body.dart';
import 'package:lostify/features/user/select_item_type/models/item_type_model.dart';

class AppConstants {
  // on boarding steps list
  static List<OnBoardingStepModel> onBoardingStepsList = [
    OnBoardingStepModel(
      image: AppLotties.searchLottie,
      title: "Recover Lost Items",
      description:
          "Lostify helps you quickly search and locate your lost belongings with ease.",
    ),
    OnBoardingStepModel(
      image: AppLotties.chatLottie,
      title: "Easy Communication",
      description:
          "Chat directly with other users to coordinate and confirm found items effortlessly.",
    ),
    OnBoardingStepModel(
      image: AppLotties.handshakeLottie,
      title: "Return Found Belongings",
      description:
          "Lostify connects you with the rightful owner for a smooth and secure return process.",
    ),
    OnBoardingStepModel(
      image: AppLotties.aiPoweredLottie,
      title: "AI Integration",
      description:
          "Lostify uses advanced AI to enhance search accuracy and match lost items intelligently.",
    ),
  ];
  // categories
  static final List<ItemTypeModel> categories = [
    ItemTypeModel(id: 1, name: 'Wallet'),
    ItemTypeModel(id: 2, name: 'Keys'),
    ItemTypeModel(id: 3, name: 'Mobile Phone'),
    ItemTypeModel(id: 4, name: 'Pets'),
    ItemTypeModel(id: 5, name: 'Cards'),
    ItemTypeModel(id: 6, name: 'Jewelry'),
    ItemTypeModel(id: 7, name: 'Medicine'),
    ItemTypeModel(id: 8, name: 'Clothes & Accessories'),
    ItemTypeModel(id: 9, name: 'Bags'),
    ItemTypeModel(id: 10, name: 'Wallet, Credit Cards & Money'),
    ItemTypeModel(id: 11, name: 'Wallet, Credit Cards & Money'),
  ];
  // card types
  static final List<ItemTypeModel> cardTypes = [
    ItemTypeModel(id: 1, name: 'Visa'),
    ItemTypeModel(id: 2, name: 'National Card'),
    ItemTypeModel(id: 3, name: 'Other'),
  ];
  // item types
  static final List<String> itemTypes = ["All", "Lost", "Found"];
  // egypt cities
  static final List<String> egyptCities = [
    "Cairo, Egypt",
    "Alexandria, Egypt",
    "Giza, Egypt",
    "Shubra El Kheima, Egypt",
    "Port Said, Egypt",
    "Suez, Egypt",
    "Luxor, Egypt",
    "Mansoura, Egypt",
    "Tanta, Egypt",
    "Asyut, Egypt",
    "Ismailia, Egypt",
    "Faiyum, Egypt",
    "Zagazig, Egypt",
    "Aswan, Egypt",
    "Damietta, Egypt",
    "Minya, Egypt",
    "Beni Suef, Egypt",
    "Qena, Egypt",
    "Sohag, Egypt",
    "Hurghada, Egypt",
    "El Mahalla El Kubra, Egypt",
    "Kafr El Sheikh, Egypt",
    "Arish, Egypt",
    "Damanhur, Egypt",
    "Banha, Egypt",
  ];
  // profile actions
  static final List<String> profileActions = [
    "My Account",
    "My Ads",
    "Chat With Us",
    "Help & Support",
    "About FIEN",
    "Log Out",
    "Delete Account",
  ];
  // user screens
  static final List<Widget> userScreens = [
    const ItemsScreenBody(),
    BlocProvider(
      create: (context) => MyAdsCubit(apiConsumer: getIt<ApiConsumer>()),
      child: const MyAdsScreenBody(),
    ),
    BlocProvider(
      create: (context) => MyChatsCubit(),
      child: const MyChatsScreenBody(),
    ),
    const SettingsScreenBody(),
  ];
  // bottom nav items
  static final List<BottomNavItem> bottomNavItems = [
    BottomNavItem(title: 'Home', icon: Icons.home),
    BottomNavItem(title: 'My Ads', icon: Icons.inventory_2_outlined),
    BottomNavItem(title: 'Chats', icon: CupertinoIcons.chat_bubble_2),
    BottomNavItem(title: 'Settings', icon: CupertinoIcons.settings),
  ];
  // app variables
  static String appName = 'Lostify';
  static String appVersion = '1.0.0';
  static String itemStatus = 'status';
  // settings items
  static final List<SettingsItemModel> settingsItems = [
    SettingsItemModel(
      icon: Icons.person,
      title: 'Profile',
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteNames.myAccountScreen);
      },
    ),
    SettingsItemModel(
      icon: Icons.lock,
      title: 'Privacy & Security',
      onTap: () {
        navigatorKey.currentState!
            .pushNamed(RouteNames.privacyAndSecurityScreen);
      },
    ),
    SettingsItemModel(
      icon: Icons.notifications,
      title: 'Notifications',
      onTap: () {},
    ),
    SettingsItemModel(
      icon: Icons.language,
      title: 'Language',
      onTap: () {},
    ),
    SettingsItemModel(
      icon: Icons.help_outline,
      title: 'Help & Support',
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteNames.helpAndSupportScreen);
      },
    ),
    SettingsItemModel(
      icon: Icons.logout,
      title: 'Logout',
      onTap: () {
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil(RouteNames.signInScreen, (_) => false);
      },
    ),
  ];
}
