import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_skripsi/features/dosen/model/dosen_model.dart';
import 'package:flutter_project_skripsi/features/dosen/repos/dosen1_repo.dart';

part 'dosen1_event.dart';
part 'dosen1_state.dart';

class Dosen1Bloc extends Bloc<Dosen1Event, Dosen1State> {
  Dosen1Bloc() : super(Dosen1Initial()) {
    on<DosenInitialFetchEvent>(dosenInitialFetchEvent);
    on<DosenFetchByIdEvent>(dosenFetchByIdEvent);
    on<DosenResetStateEvent>(dosenResetStateEvent);
  }

  FutureOr<void> dosenInitialFetchEvent(
      DosenInitialFetchEvent event, Emitter<Dosen1State> emit) async {
    if (event.type == "dosen1") {
      emit(const DosenLoadingState(type: 'dosen1'));
    } else if (event.type == "dosen2") {
      emit(const DosenLoadingState(type: 'dosen2'));
    }

    try {
      List<Dosen> listDosen = await Dosen1Repo.fetchDosen(event.type);
      if (event.type == "dosen1") {
        listDosen = listDosen
            .where((dosen) =>
                dosen.prodi == "Informatika" &&
                (event.kepakaran == null || dosen.kepakaran == event.kepakaran))
            .toList();
        emit(Dosen1FetchingSuccessfulState(
            listDosen: listDosen, type: 'dosen1'));
        // add(const DosenInitialFetchEvent(type: 'dosen2'));
      } else if (event.type == "dosen2") {
        listDosen = listDosen.where((dosen) => dosen.jabatan == "").toList();
        emit(Dosen2FetchingSuccessfulState(
            listDosen: listDosen, type: 'dosen2'));
      }
    } catch (e) {
      if (event.type == "dosen1") {
        emit(DosenFetchingErrorState(error: e.toString(), type: 'dosen1'));
      } else if (event.type == "dosen2") {
        emit(DosenFetchingErrorState(error: e.toString(), type: 'dosen2'));
      }
    }
  }

  FutureOr<void> dosenFetchByIdEvent(event, Emitter<Dosen1State> emit) async {
    emit(const DosenLoadingState(type: "dosen1"));
    try {
      Dosen dosenDetail = await Dosen1Repo.fetchDosenById(event.id);
      print(dosenDetail);
      emit(DosenDetailFetchingSuccessfulState(detail: dosenDetail));
    } catch (e) {
      emit(DosenFetchingErrorState(error: e.toString(), type: "dosen1"));
    }
  }

  FutureOr<void> dosenResetStateEvent(
      DosenResetStateEvent event, Emitter<Dosen1State> emit) async {
    emit(DosenResetState());
  }
}
