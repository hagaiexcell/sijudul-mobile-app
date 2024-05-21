import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileFetchEvent>(profileFetchEvent);
  }

  FutureOr<void> profileFetchEvent(
      ProfileFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataJson = prefs.getString('userData');

      if (userDataJson != null) {
        final userData = jsonDecode(userDataJson);
        emit(ProfileLoadedState(userData));
      } else {
        emit(const ProfileLoadedState({}));
      }
    } catch (error) {
      emit(ProfileErrorState(error.toString()));
    }
  }
}
