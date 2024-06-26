part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileFetchEvent extends ProfileEvent {
  final int? id;

  const ProfileFetchEvent({required this.id});
}

class ProfileUpdateEvent extends ProfileEvent {
  final int? id;
  final String email;
  final String name;

  const ProfileUpdateEvent(
      {required this.id, required this.email, required this.name});
}
