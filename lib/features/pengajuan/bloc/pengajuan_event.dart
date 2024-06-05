// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pengajuan_bloc.dart';

sealed class PengajuanEvent extends Equatable {
  const PengajuanEvent();

  @override
  List<Object> get props => [];
}

class PengajuanInitialFetchEvent extends PengajuanEvent {
  final bool isInitial;

  const PengajuanInitialFetchEvent({required this.isInitial});
}

class PengajuanFetchByIdEvent extends PengajuanEvent {
  final int id;
  const PengajuanFetchByIdEvent({
    required this.id,
  });
}

class PengajuanResetStateEvent extends PengajuanEvent {}
