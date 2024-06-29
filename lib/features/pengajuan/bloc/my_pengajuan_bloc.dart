import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:flutter_project_skripsi/features/pengajuan/repos/pengajuan_repo.dart';

part 'my_pengajuan_event.dart';
part 'my_pengajuan_state.dart';

class MyPengajuanBloc extends Bloc<MyPengajuanEvent, MyPengajuanState> {
  MyPengajuanBloc() : super(MyPengajuanInitial()) {
    on<MyPengajuanFetchEvent>(myPengajuanFetchEvent);
  }

  FutureOr<void> myPengajuanFetchEvent(
      event, Emitter<MyPengajuanState> emit) async {
    emit(MyPengajuanLoadingState());
    try {
      // Fetch data from API
      final listPengajuanUser =
          await PengajuanRepo.fetchAllPengajuanByIdMahasiswa(
              id: event.id, query: "");

      emit(MyPengajuanSuccessfulState(listPengajuan: listPengajuanUser));
    } catch (e) {
      emit(MyPengajuanErrorState(e.toString()));
    }
  }
}
