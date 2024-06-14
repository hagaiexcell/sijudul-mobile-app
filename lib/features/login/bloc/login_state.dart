part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginSubmitSuccessState extends LoginState {
  final User user;
  const LoginSubmitSuccessState({required this.user});
}

class RegisterSubmitSuccessState extends LoginState {}

class LoginSubmitFailureState extends LoginState {
  final String message;
  const LoginSubmitFailureState({
    required this.message,
  });
}

class RegisterSubmitFailureState extends LoginState {
  final String message;
  const RegisterSubmitFailureState({
    required this.message,
  });
}

class LoginLoadingState extends LoginState {}
