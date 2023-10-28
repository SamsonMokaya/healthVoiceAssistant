import 'package:diseases/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:diseases/constants/constants.dart';
import 'package:diseases/constants/theme.dart';
import 'package:diseases/repositories/authentication/auth_repository.dart';
import 'package:diseases/repositories/user_repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diseases/routes.dart' as route;
import 'package:fluttertoast/fluttertoast.dart';

import 'business_logic/bloc/auth_status/auth_status_bloc.dart';
import 'business_logic/cubit/profile_page_view/profile_view_cubit.dart';
import 'business_logic/cubit/togglePassword/toggle_password_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
          // authbloc
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: AuthRepository()),
          ),

          // cubits
          BlocProvider<TogglePasswordCubit>(
            create: (context) => TogglePasswordCubit(),
          ),
          BlocProvider<ProfileViewCubit>(
              create: (context) => ProfileViewCubit()),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (authcontext, state) {
            if (state is AuthenticationError) {
              Fluttertoast.showToast(
                msg: state.errorMessage,
                backgroundColor: Colors.red,
              );
            } else if (state is AuthenticationSuccess) {
              if (state.message.isNotEmpty) {
                Fluttertoast.showToast(
                  msg: state.message,
                  backgroundColor: Colors.green,
                );
              }
              if (state.action == 'register') {
                navigatorKey.currentState!
                    .pushReplacementNamed(route.loginScreen);
              } else if (state.action == 'login') {
                print('helloooooooo');

                navigatorKey.currentState!.pushReplacementNamed(
                  route.otpScreen,
                  arguments: {
                    'email': currentUser.email,
                    'password': currentUser.password,
                  },
                );
              } else if (state.action == 'otp') {
                navigatorKey.currentState!
                    .pushReplacementNamed(route.homeScreen);
              }
            }
          },
          child: BlocConsumer<AuthStatusBloc, AuthStatusState>(
            listener: (context, state) {
              if (state is UserAuthenticated) {
                navigatorKey.currentState!
                    .pushReplacementNamed(route.homeScreen);
              } else {
                navigatorKey.currentState!
                    .pushReplacementNamed(route.loginScreen);
              }
              print('--------------auth status-------');
              print(state.toString());
              print(currentUser.toJson());
              print('--------------auth status------- ');
            },
            builder: (context, state) => MaterialApp(
              title: 'Diseases Prediction',
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: themeData(),
              onGenerateRoute: (settings) => route.onGeneratedRoute(settings),
              initialRoute:
                  context.read<AuthStatusBloc>().state is UserAuthenticated
                      ? route.homeScreen
                      : route.loginScreen,
            ),
          ),
        ),
      ),
    );
  }
}
