import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/features/dosen/model/dosen_model.dart';
import 'package:flutter_project_skripsi/features/dosen/repos/dosen1_repo.dart';

part 'dosen1_event.dart';
part 'dosen1_state.dart';

class Dosen1Bloc extends Bloc<Dosen1Event, Dosen1State> {
  Dosen1Bloc() : super(Dosen1Initial()) {
    on<DosenInitialFetchEvent>(dosenInitialFetchEvent);
  }

  FutureOr<void> dosenInitialFetchEvent(
      DosenInitialFetchEvent event, Emitter<Dosen1State> emit) async {
    List<Dosen> listDosen = await Dosen1Repo.fetchDosen();
    
    emit(DosenFetchingSuccessfulState(listDosen: listDosen));
  }
}
