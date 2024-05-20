part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitEvent extends LoginEvent {
  final String nim;
  final String password;

  const LoginSubmitEvent({
    required this.nim,
    required this.password,
  });

  @override
  List<Object> get props => [nim, password];
}

