import 'package:diseases/constants/constants.dart';
import 'package:diseases/repositories/authentication/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthenticationLoding(action: 'login')) {
    on<Register>(_onRegister);
    on<StartApp>(_onStartApp);
    on<Login>(_onLogin);
    on<LogOut>(_onLogOut);
  }

  Future<void> _onRegister(Register event, Emitter<AuthState> emit) async {
    emit(const RegistrationInProgress());
    try {
      final user = await _authRepository.register(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      );
      if (user != null) {
        emit(AuthenticationSuccess(user: user, action: 'register'));
      } else {
        emit(const AuthenticationError(errorMessage: '', action: 'register'));
      }
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(AuthenticationError(errorMessage: errorMessage, action: 'register'));
    }
  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(const LoginInProgress());
    try {
      UserModel? user;
      String message = '';
      if (event.otp.isNotEmpty) {
        user = await _authRepository.login(
          email: event.username,
          password: event.password,
          otp: event.otp,
        );
      } else {
        user = UserModel(
          email: event.username,
          password: event.password,
          otp: '',
        );
        bool done = await _authRepository.sendOtp(email: event.username);
        if (done) {
          message = 'Otp successfully sent to ${event.username}';
        }
      }
      currentUser = user;
      if (user != null) {
        emit(AuthenticationSuccess(
            user: user, message: message, action: 'login'));
      } else {
        emit(const AuthenticationError(errorMessage: '', action: 'login'));
      }
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(AuthenticationError(errorMessage: errorMessage, action: 'login'));
    }
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.logOut();
      emit(AuthenticationSuccess(user: UserModel.empty, action: 'logout'));
    } catch (e) {
      emit(AuthenticationError(errorMessage: e.toString(), action: 'logout'));
    }
  }

  Future<void> _onStartApp(StartApp event, Emitter<AuthState> emit) async {
    emit(AuthenticationSuccess(user: UserModel.empty, action: 'start'));
  }
}
