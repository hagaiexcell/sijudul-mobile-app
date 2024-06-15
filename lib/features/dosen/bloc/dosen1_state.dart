part of 'dosen1_bloc.dart';

sealed class Dosen1State extends Equatable {
  const Dosen1State();

  @override
  List<Object> get props => [];
}

final class Dosen1Initial extends Dosen1State {}

final class Dosen1FetchingSuccessfulState extends Dosen1State {
  final String type;
  final List<Dosen> listDosen;

  const Dosen1FetchingSuccessfulState(
      {required this.listDosen, required this.type});
}

final class Dosen2FetchingSuccessfulState extends Dosen1State {
  final String type;
  final List<Dosen> listDosen;

  const Dosen2FetchingSuccessfulState(
      {required this.listDosen, required this.type});
}

final class DosenFetchingErrorState extends Dosen1State {
  final String error;
  final String type;

  const DosenFetchingErrorState({required this.error, required this.type});
}

final class DosenLoadingState extends Dosen1State {
  final String type;

  const DosenLoadingState({required this.type});
}

final class DosenDetailFetchingSuccessfulState extends Dosen1State {
  final Dosen detail;

  const DosenDetailFetchingSuccessfulState({required this.detail});
}

final class DosenResetState extends Dosen1State{}