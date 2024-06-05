import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:flutter_project_skripsi/features/pengajuan/repos/pengajuan_repo.dart';

part 'pengajuan_event.dart';
part 'pengajuan_state.dart';

class PengajuanBloc extends Bloc<PengajuanEvent, PengajuanState> {
  List<Pengajuan>? _cachedPengajuanList;
  PengajuanBloc() : super(PengajuanInitial()) {
    on<PengajuanInitialFetchEvent>(pengajuanInitialFetchEvent);
    on<PengajuanFetchByIdEvent>(pengajuanFetchByIdEvent);
    on<PengajuanResetStateEvent>(pengajuanResetStateEvent);
  }

  FutureOr<void> pengajuanInitialFetchEvent(
      PengajuanInitialFetchEvent event, Emitter<PengajuanState> emit) async {
    if (_cachedPengajuanList == null) {
      emit(PengajuanLoadingState());
      try {
        // Fetch data from API
        final listPengajuan = await PengajuanRepo.fetchAllPengajuan();
        _cachedPengajuanList = listPengajuan;
        emit(PengajuanFetchingSuccessfulState(listPengajuan: listPengajuan));
      } catch (e) {
        emit(PengajuanFetchingErrorState(e.toString()));
      }
    } else {
      emit(PengajuanLoadingState());

      if (event.isInitial) {
        final listPengajuan = await PengajuanRepo.fetchAllPengajuan();
        emit(PengajuanFetchingSuccessfulState(listPengajuan: listPengajuan));
      } else {
        emit(PengajuanFetchingSuccessfulState(
            listPengajuan: _cachedPengajuanList!));
      }
    }
  }

  FutureOr<void> pengajuanFetchByIdEvent(
      PengajuanFetchByIdEvent event, Emitter<PengajuanState> emit) async {
    emit(PengajuanLoadingState());
    try {
      Pengajuan pengajuanDetail =
          await PengajuanRepo.fetchPengajuanById(event.id);

      emit(PengajuanDetailFetchingSuccessfulState(
          pengajuanDetail: pengajuanDetail));
    } catch (e) {
      emit(PengajuanFetchingErrorState(e.toString()));
    }
  }

  FutureOr<void> pengajuanResetStateEvent(
      PengajuanResetStateEvent event, Emitter<PengajuanState> emit) {
    emit(PengajuanInitial());
  }
}
