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

class PengajuanFetchAllByMahasiswaIdEvent extends PengajuanEvent {
  final int? id;
  final bool isInitial;

  const PengajuanFetchAllByMahasiswaIdEvent(
      {required this.id, required this.isInitial});
}

class MyPengajuanListEvent extends PengajuanEvent {
  final int id;
  final bool isInitial;

  const MyPengajuanListEvent(
      {required this.id, required this.isInitial});
}



class PengajuanFetchByIdEvent extends PengajuanEvent {
  final int id;
  const PengajuanFetchByIdEvent({
    required this.id,
  });
}

class PengajuanResetStateEvent extends PengajuanEvent {}

class PengajuanSearchEvent extends PengajuanEvent {
  final String query;
  final String type;
  final int? id;

  const PengajuanSearchEvent(
      {required this.query, required this.type, this.id});
}

class PengajuanCreateEvent extends PengajuanEvent {
  final int? userId;
  final String peminatan;
  final String judul;
  final String tempatPenelitian;
  final String rumusanMasalah;
  final int dosen1Id;
  final int dosen2Id;

  const PengajuanCreateEvent(
      {required this.userId,
      required this.peminatan,
      required this.judul,
      required this.tempatPenelitian,
      required this.rumusanMasalah,
      required this.dosen1Id,
      required this.dosen2Id});
}
