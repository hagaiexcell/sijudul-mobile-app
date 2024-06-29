part of 'my_pengajuan_bloc.dart';

sealed class MyPengajuanEvent extends Equatable {
  const MyPengajuanEvent();

  @override
  List<Object> get props => [];
}

final class MyPengajuanFetchEvent extends MyPengajuanEvent {
  final int id;

  const MyPengajuanFetchEvent({required this.id});
}
