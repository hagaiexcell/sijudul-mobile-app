part of 'my_pengajuan_bloc.dart';

sealed class MyPengajuanState extends Equatable {
  const MyPengajuanState();

  @override
  List<Object> get props => [];
}

final class MyPengajuanInitial extends MyPengajuanState {}

final class MyPengajuanLoadingState extends MyPengajuanState {}

final class MyPengajuanSuccessfulState extends MyPengajuanState {
  final List<Pengajuan> listPengajuan;

  const MyPengajuanSuccessfulState({required this.listPengajuan});
}

class MyPengajuanErrorState extends MyPengajuanState {
  final String error;

  const MyPengajuanErrorState(this.error);
}
