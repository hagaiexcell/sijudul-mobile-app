part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitialState extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final Map<String, dynamic> userData;

  const ProfileLoadedState(this.userData);
}

class ProfileErrorState extends ProfileState {
  final String message;

  const ProfileErrorState(this.message);
}
