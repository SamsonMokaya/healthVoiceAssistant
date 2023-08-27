import 'package:flutter/material.dart';
// import 'package:recycle_rush/presentation/deposit_points_screen/deposit_screen.dart';

// import '../presentation/landing_screen.dart';
// import '../presentation/profile_screen.dart';
// import '../presentation/settings_screen.dart';
// import '../presentation/statistics_screen.dart';

const String landingScreen = 'landingScreen';
const String depositPointScreen = 'depositPointScreen';
const String profileScreen = 'profileScreen';
const String settingsScreen = 'settingsScreen';
const String statisticsScreen = 'statisticsScreen';

//control pur page route flow
Route<dynamic> onGeneratedRoute(RouteSettings settings) {
  switch (settings.name) {
    // case landingScreen:
    //   return MaterialPageRoute(builder: (context) => LandingScreen());
    // case depositPointScreen:
    //   return MaterialPageRoute(builder: (context) => DepositPointScreen());
    // case profileScreen:
    //   return MaterialPageRoute(builder: (context) => const ProfileScreen());
    // case settingsScreen:
    //   return MaterialPageRoute(builder: (context) => const SettingsScreen());
    // case statisticsScreen:
    //   return MaterialPageRoute(builder: (context) => const StatisticsScreen());
    default:
      throw ('This route name does not exist yet');
  }
}
