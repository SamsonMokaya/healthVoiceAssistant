import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart' as route;
import '../constants/theme.dart';

void main() {
  // Set the system status bar color to transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Disease Prediction',
        debugShowCheckedModeBanner: false,
        theme: themeData(),
        onGenerateRoute: route.onGeneratedRoute,
        initialRoute: route.landingScreen);
  }
}
