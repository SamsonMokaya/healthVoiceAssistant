import 'package:diseases/presentations/views/suggestion_screen.dart';
import 'package:flutter/material.dart';

import 'presentations/views/home_screen.dart';
import 'presentations/views/landing_screen.dart';
import 'presentations/views/settings_screen.dart';

const String landingScreen = 'landingScreen';
const String homeScreen = 'homeScreen';
const String suggestionsScreen = 'suggestionsScreen';
const String settingsScreen = 'settingsScreen';

//control pur page route flow
Route<dynamic> onGeneratedRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingScreen:
      return MaterialPageRoute(builder: (context) => const LandingScreen());
    case homeScreen:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case suggestionsScreen:
      return MaterialPageRoute(builder: (context) => const SuggestionsScreen());
    case settingsScreen:
      return MaterialPageRoute(builder: (context) => const SettingsScreen());
    default:
      throw ('This route name does not exist yet');
  }
}
