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

class RegisterSubmitEvent extends LoginEvent {
  final String name;
  final String nim;
  final String email;
  final String password;
  final String prodi;
  final String tempatLahir;
  final String? tanggalLahir;
  final String jenisKelamin;
  final String agama;
  final String noTelpon;
  final int? angkatan;
  final int? sks;

  const RegisterSubmitEvent(
      {required this.name,
      required this.nim,
      required this.email,
      required this.password,
      required this.prodi,
      required this.tempatLahir,
      required this.tanggalLahir,
      required this.jenisKelamin,
      required this.agama,
      required this.noTelpon,
      required this.angkatan,
      required this.sks});
}
