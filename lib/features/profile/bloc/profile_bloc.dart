import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_skripsi/features/profile/repos/profile_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileFetchEvent>(profileFetchEvent);
    on<ProfileUpdateEvent>(profileUpdateEvent);
    on<ProfileLogoutEvent>(profileLogoutEvent);
  }

  // FutureOr<void> profileFetchEvent(
  //     ProfileFetchEvent event, Emitter<ProfileState> emit) async {
  //   emit(ProfileLoadingState());
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final userDataJson = prefs.getString('userData');

  //     if (userDataJson != null) {
  //       final userData = jsonDecode(userDataJson);
  //       // print(userData);
  //       emit(ProfileLoadedState(userData));
  //     } else {
  //       emit(const ProfileLoadedState({}));
  //     }
  //   } catch (error) {
  //     emit(ProfileErrorState(error.toString()));
  //   }
  // }

  FutureOr<void> profileFetchEvent(
      ProfileFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataJson = prefs.getString('userData');

      if (userDataJson != null) {
        // final userData = jsonDecode(userDataJson);
        // print(userData['id']);
        Map<String, dynamic> user = await ProfileRepo.getProfile(id: event.id);
        // print(user['mahasiswa']);
        emit(ProfileLoadedState(user['mahasiswa']));
      } else {
        emit(const ProfileLoadedState({}));
      }
    } catch (error) {
      emit(ProfileErrorState(error.toString()));
    }
  }

  FutureOr<void> profileUpdateEvent(
      ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      // print(
      Map<String, dynamic> user = await ProfileRepo.updateProfile(
          email: event.email,
          id: event.id,
          name: event.name,
          agama: event.agama,
          jenisKelamin: event.jenisKelamin,
          tanggalLahir: event.tanggalLahir,
          tempatLahir: event.tempatLahir,
          noTelpon : event.noTelpon
          );
      emit(ProfileLoadedState(user));
    } catch (error) {
      emit(ProfileErrorState(error.toString()));
    }
  }

  FutureOr<void> profileLogoutEvent(
      ProfileLogoutEvent event, Emitter<ProfileState> emit) {
    emit(ProfileInitialState());
  }
}
