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

class LoginSubmitFailureState extends LoginState {
  final String message;
  const LoginSubmitFailureState({
    required this.message,
  });
}

class LoginLoadingState extends LoginState {}
