part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostsInitialsFetchEvent extends PostsEvent {}

class PostsAddEvent extends PostsEvent {}