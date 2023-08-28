import 'package:flutter/material.dart';

import 'presentations/views/home_screen.dart';
import 'presentations/views/landing_screen.dart';

const String landingScreen = 'landingScreen';
const String homeScreen = 'homeScreen';

//control pur page route flow
Route<dynamic> onGeneratedRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingScreen:
      return MaterialPageRoute(builder: (context) => const LandingScreen());
    case homeScreen:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    default:
      throw ('This route name does not exist yet');
  }
}
