import 'package:diseases/business_logic/bloc/auth_status/auth_status_bloc.dart';
import 'package:diseases/presentations/views/auth/login_screen.dart';
import 'package:diseases/presentations/views/auth/otp.dart';
import 'package:diseases/presentations/views/auth/sign_up_screen.dart';
import 'package:diseases/presentations/views/home_screen.dart';
import 'package:diseases/presentations/views/landing_screen.dart';
import 'package:diseases/presentations/views/settings_screen.dart';
import 'package:diseases/presentations/views/suggestion_screen.dart';
import 'package:flutter/material.dart';

typedef RouteBuilder = Widget Function(BuildContext context);

const String landingScreen = 'landingScreen';
const String homeScreen = 'homeScreen';
const String suggestionsScreen = 'suggestionsScreen';
const String settingsScreen = 'settingsScreen';
const String loginScreen = 'loginScreen';
const String registerScreen = 'registerScreen';
const String otpScreen = 'otpScreen';

Route<dynamic> onGeneratedRoute(
    RouteSettings settings, AuthStatusState authStatus) {
  final Map<String, RouteBuilder> routes = {
    landingScreen: (context) => const LandingScreen(),
    homeScreen: (context) => const HomeScreen(),
    otpScreen: (context) =>  Otp(),
    suggestionsScreen: (context) => const SuggestionsScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => SignUpScreen(),
  };

  final RouteBuilder? builder = routes[settings.name];
  if (builder != null) {
    if (authStatus is UserAuthenticated ||
        !requiresAuth.contains(settings.name)) {
      return MaterialPageRoute(builder: builder);
    } else {
      return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  } else {
    throw ('This route name does not exist yet');
  }
}

const List<String> requiresAuth = [
  homeScreen,
  suggestionsScreen,
  settingsScreen
];
