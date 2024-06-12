import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project_skripsi/features/posts/model/posts_data_ui_model.dart';
import 'package:flutter_project_skripsi/features/posts/repos/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialsFetchEvent>(postsInitialsFetchEvent);
    on<PostsAddEvent>(postsAddEvent);
  }

  FutureOr<void> postsInitialsFetchEvent(
      PostsInitialsFetchEvent event, Emitter<PostsState> emit) async {
    List<PostsDataUiModel> posts = await PostRepo.fetchPosts();

    // var env = dotenv.
    //    var baseUrl = dotenv.get("BASE_URL");
    // var response = await client.get(Uri.parse(baseUrl));
    // var jsonDecode2 = jsonDecode(response.body);

    // print(jsonDecode2['message']);

    emit(PostFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postsAddEvent(
      PostsAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostRepo.addPosts();
    debugPrint(success.toString());
    if (success) {
      emit(PostsAdditionSuccessState());
    } else {
      emit(PostsAdditionErrorState());
    }
  }
}
