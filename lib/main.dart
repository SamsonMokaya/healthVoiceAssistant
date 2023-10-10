import 'package:diseases/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:diseases/constants/theme.dart';
import 'package:diseases/repositories/authentication/auth_repository.dart';
import 'package:diseases/repositories/user_repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diseases/routes.dart' as route;

import 'business_logic/bloc/auth_status/auth_status_bloc.dart';
import 'business_logic/cubit/togglePassword/toggle_password_cubit.dart';

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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<UsersRepository>(
          create: (context) => UsersRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthStatusBloc>(
            create: (context) =>
                AuthStatusBloc(authRepository: AuthRepository())
                  ..add(CheckUserStatus()),
          ),
          //authbloc
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: AuthRepository()),
          ),

          // cubits
          BlocProvider<TogglePasswordCubit>(
            create: (context) => TogglePasswordCubit(),
          ),
        ],
        child: BlocBuilder<AuthStatusBloc, AuthStatusState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Geospur',
              debugShowCheckedModeBanner: false,
              theme: themeData(),
              onGenerateRoute: (settings) =>
                  route.onGeneratedRoute(settings, state),
              initialRoute: route.otpScreen,
            );
          },
        ),
      ),
    );
  }
}
