part of 'dosen1_bloc.dart';

sealed class Dosen1Event extends Equatable {
  const Dosen1Event();

  @override
  List<Object> get props => [];
}

class DosenInitialFetchEvent extends Dosen1Event{}