// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pengajuan_bloc.dart';

sealed class PengajuanState extends Equatable {
  const PengajuanState();

  @override
  List<Object> get props => [];
}

final class PengajuanInitial extends PengajuanState {}

final class PengajuanResetState extends PengajuanState {}

final class PengajuanLoadingState extends PengajuanState {}

final class PengajuanFetchingSuccessfulState extends PengajuanState {
  final List<Pengajuan> listPengajuan;

  const PengajuanFetchingSuccessfulState({required this.listPengajuan});
}

final class PengajuanDetailFetchingSuccessfulState extends PengajuanState {
  final Pengajuan pengajuanDetail;

  const PengajuanDetailFetchingSuccessfulState({required this.pengajuanDetail});
}

class PengajuanFetchingErrorState extends PengajuanState {
  final String error;

  const PengajuanFetchingErrorState(this.error);
}
