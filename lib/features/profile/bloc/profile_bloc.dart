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
      Map<String, dynamic> user = await ProfileRepo.updateProfile(
          email: event.email, id: event.id, name: event.name);
      // print(user);
      emit(ProfileLoadedState(user['result']));
    } catch (error) {
      emit(ProfileErrorState(error.toString()));
    }
  }
}
