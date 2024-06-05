part of 'dosen1_bloc.dart';

sealed class Dosen1State extends Equatable {
  const Dosen1State();

  @override
  List<Object> get props => [];
}

final class Dosen1Initial extends Dosen1State {}

final class DosenFetchingSuccessfulState extends Dosen1State {
  final List<Dosen> listDosen;

  const DosenFetchingSuccessfulState({required this.listDosen});
}

final class DosenFetchingErrorState extends Dosen1State {
  final String error;

  const DosenFetchingErrorState({required this.error});
}
