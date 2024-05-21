import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/features/login/repos/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitEvent>(loginSubmitEvent);
  }

  FutureOr<void> loginSubmitEvent(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {
    var result = await LoginRepo.loginMahasiswa(event.nim, event.password);
    debugPrint(result.toString());
    if (result.containsKey('data')) {
      final token = result['token'];
      await _saveToken(token);
      await _saveUserData(result['data']);
      emit(LoginIdleState());
      emit(LoginSubmitSuccessState());
    } else {
      emit(LoginIdleState());
      emit(LoginSubmitFailureState(message: result['error']));
    }
    // debugPrint(result['data'].toString());
  }

  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = jsonEncode(userData);
    await prefs.setString('userData', userDataJson);
  }
}
