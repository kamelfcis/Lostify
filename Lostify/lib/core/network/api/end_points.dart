import 'package:lostify/core/config/env_config.dart';

class EndPoints {
  static const String baseurl = EnvConfig.apiBaseUrl;
  static const String login = 'login/';
  static const String register = 'register/';
  static const String token = 'token/';
  static const String tokenRefresh = 'token/refresh/';
  static const String getFoundItems = 'ads/';
  static const String addItem = 'ads/';
  static const String getItemTypes = 'item-types/';
  static const String cardTypes = 'card-types/';
  static const String cardAds = 'card-ads/';
}

class ApiKeys {
  static String userName = 'username';
  static String firstName = 'first_name';
  static String lastName = 'last_name';
  static String email = 'email';
  static String password = 'password';
  static String password2 = 'password2';
  static String username = 'username';
  static String fullName = 'fullName';
}
