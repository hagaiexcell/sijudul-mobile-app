part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginSubmitSuccessState extends LoginState {}

class LoginSubmitFailureState extends LoginState {
  final String message;
  const LoginSubmitFailureState({
    required this.message,
  });
}

class LoginIdleState extends LoginState{}


