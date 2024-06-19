part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationFetchingSuccessfulState extends NotificationState {
  final List<Notifications> listNotifications;

  const NotificationFetchingSuccessfulState({required this.listNotifications});
}

final class NotificationFetchingErrorState extends NotificationState {
  final String error;

  const NotificationFetchingErrorState({required this.error});
}
