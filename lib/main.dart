import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart' as route;
import '../constants/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [
        //cubit for Navigations
        // BlocProvider<LandScreenPageCubit>(
        //     create: (context) => LandScreenPageCubit())
      ],
      child: MaterialApp(
          title: 'Recycle Rush',
          debugShowCheckedModeBanner: false,
          theme: themeData(),
          onGenerateRoute: route.onGeneratedRoute,
          initialRoute: route.landingScreen),
    );
  }
}
