import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_skripsi/features/notifications/model/notifications_model.dart';
import 'package:flutter_project_skripsi/features/notifications/repos/notifications_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationFetchAllEvent>(notificationFetchAllEvent);
  }

  FutureOr<void> notificationFetchAllEvent(
      NotificationFetchAllEvent event, Emitter<NotificationState> emit) async {
    try {
      final List<Notifications> listNotifications =
          await NotificationsRepo.fetchAllNotifications();
      emit(NotificationFetchingSuccessfulState(
          listNotifications: listNotifications));
    } catch (e) {
      emit(NotificationFetchingErrorState(error: e.toString()));
    }
  }
}
