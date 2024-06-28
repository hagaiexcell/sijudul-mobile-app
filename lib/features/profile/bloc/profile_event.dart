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
  final String tempatLahir;
  final String? tanggalLahir;
  final String jenisKelamin;
  final String agama;
  // final String noTelpon;

  const ProfileUpdateEvent({
    required this.id,
    required this.email,
    required this.name,
    required this.tempatLahir,
    this.tanggalLahir,
    required this.jenisKelamin,
    required this.agama,
    // required this.noTelpon
  });
}

class ProfileLogoutEvent extends ProfileEvent {}
