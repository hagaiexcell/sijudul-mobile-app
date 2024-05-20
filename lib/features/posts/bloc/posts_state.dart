// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}

abstract class PostsActionState extends PostsState{}

class PostsInitial extends PostsState {}

class PostFetchingSuccessfulState extends PostsState {
  final List<PostsDataUiModel> posts;
  const PostFetchingSuccessfulState({
    required this.posts,
  });

}

class PostsAdditionSuccessState extends PostsActionState{}

class PostsAdditionErrorState extends PostsActionState{}
