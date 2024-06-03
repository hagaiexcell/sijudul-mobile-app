import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/features/login/repos/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_project_skripsi/features/login/model/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitEvent>(loginSubmitEvent);
  }

  FutureOr<void> loginSubmitEvent(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      var result = await LoginRepo.loginMahasiswa(event.nim, event.password);
      // print(result);

      if (result is User) {
        await _saveToken(result.token);
        await _saveUserData(result);
        emit(LoginSubmitSuccessState(user: result));
        emit(LoginSubmitSuccessState(user: result));
      } else {
        emit(LoginSubmitFailureState(message: result['error']));
      }
    } catch (e) {
      emit(LoginSubmitFailureState(message: e.toString()));
    } finally {
      emit(LoginInitial());
    }

    // debugPrint(result['data'].toString());
  }

  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> _saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = jsonEncode(user.toJson());
    await prefs.setString('userData', userDataJson);
  }
}
