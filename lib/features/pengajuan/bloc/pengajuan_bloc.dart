import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:flutter_project_skripsi/features/pengajuan/repos/pengajuan_repo.dart';

part 'pengajuan_event.dart';
part 'pengajuan_state.dart';

class PengajuanBloc extends Bloc<PengajuanEvent, PengajuanState> {
  List<Pengajuan>? _cachedPengajuanList;
  List<Pengajuan>? _cachedPengajuanUserList;
  PengajuanBloc() : super(PengajuanInitial()) {
    on<PengajuanInitialFetchEvent>(pengajuanInitialFetchEvent);
    on<PengajuanFetchAllByMahasiswaIdEvent>(
        pengajuanFetchAllByMahasiswaIdEvent);
    on<PengajuanFetchByIdEvent>(pengajuanFetchByIdEvent);
    on<PengajuanResetStateEvent>(pengajuanResetStateEvent);
    on<PengajuanCreateEvent>(pengajuanCreateEvent);
  }

  FutureOr<void> pengajuanInitialFetchEvent(
      PengajuanInitialFetchEvent event, Emitter<PengajuanState> emit) async {
    emit(PengajuanLoadingState());
    if (_cachedPengajuanList == null) {
      try {
        // Fetch data from API
        final listPengajuan = await PengajuanRepo.fetchAllPengajuan();
        _cachedPengajuanList = listPengajuan;
        emit(PengajuanFetchingSuccessfulState(listPengajuan: listPengajuan));
      } catch (e) {
        emit(PengajuanFetchingErrorState(e.toString()));
      }
    } else {
      // emit(PengajuanLoadingState());

      if (event.isInitial) {
        final listPengajuan = await PengajuanRepo.fetchAllPengajuan();
        _cachedPengajuanList = listPengajuan;

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

      // print(pengajuanDetail.tempatPenelitian);

      emit(PengajuanDetailFetchingSuccessfulState(
          pengajuanDetail: pengajuanDetail));
    } catch (e) {
      emit(PengajuanFetchingErrorState(e.toString()));
    }
  }

  FutureOr<void> pengajuanResetStateEvent(
      PengajuanResetStateEvent event, Emitter<PengajuanState> emit) {
    emit(PengajuanResetState());
  }

  FutureOr<void> pengajuanFetchAllByMahasiswaIdEvent(
      PengajuanFetchAllByMahasiswaIdEvent event,
      Emitter<PengajuanState> emit) async {
   
    emit(PengajuanLoadingState());
    if (_cachedPengajuanUserList == null) {
      try {
        // Fetch data from API
        final listPengajuanUser =
            await PengajuanRepo.fetchAllPengajuanByIdMahasiswa(event.id);
        _cachedPengajuanUserList = listPengajuanUser;
        emit(
            PengajuanFetchingSuccessfulState(listPengajuan: listPengajuanUser));
      } catch (e) {
        emit(PengajuanFetchingErrorState(e.toString()));
      }
    } else {
      if (event.isInitial) {
        final listPengajuanUser =
            await PengajuanRepo.fetchAllPengajuanByIdMahasiswa(event.id);
        _cachedPengajuanUserList = listPengajuanUser;
        emit(
            PengajuanFetchingSuccessfulState(listPengajuan: listPengajuanUser));
      } else {
        emit(PengajuanFetchingSuccessfulState(
            listPengajuan: _cachedPengajuanUserList!));
      }
    }
  }

  FutureOr<void> pengajuanCreateEvent(
      event, Emitter<PengajuanState> emit) async {
    emit(PengajuanCreateLoadingState());
    try {
      final checkSimilarity = await PengajuanRepo.similarityCheck(event.judul);
      
      if (checkSimilarity.containsKey('similarity') &&
          checkSimilarity['similarity'] != null) {
        double similarity = checkSimilarity['similarity'];
        emit(PengajuanCreateErrorState(
            error:
                '${checkSimilarity['message']} with "${checkSimilarity['similar']}" (${similarity.toStringAsFixed(2)}%)'));
      } else {
        await PengajuanRepo.createPengajuan(
            id: event.userId,
            judul: event.judul,
            peminatan: event.peminatan,
            rumusanMasalah: event.rumusanMasalah,
            tempatPenelitian: event.tempatPenelitian,
            dosen1Id: event.dosen1Id,
            dosen2Id: event.dosen2Id);
        emit(PengajuanCreateSuccessfullState());
      }
    } catch (e) {
      emit(PengajuanCreateErrorState(error: e.toString()));
    }
  }
}
