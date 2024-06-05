// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dosen1_bloc.dart';

sealed class Dosen1Event extends Equatable {
  const Dosen1Event();

  @override
  List<Object> get props => [];
}

final class DosenInitialFetchEvent extends Dosen1Event {
  final String type;
  const DosenInitialFetchEvent({
    required this.type,
  });
}
