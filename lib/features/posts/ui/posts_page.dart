import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/posts/bloc/posts_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostsBloc postsBloc = context.read<PostsBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      postsBloc.add(PostsInitialsFetchEvent());
    });

    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
        title: "Daftar Judul Mahasiswa",
        context: context,
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   postsBloc.add(PostsAddEvent());
      //   postsBloc.add(PostsInitialsFetchEvent());
      // }),
      body: BlocConsumer<PostsBloc, PostsState>(
        buildWhen: (previous, current) => current is! PostsActionState,
        listenWhen: (previous, current) => current is PostsActionState,
        listener: (context, state) => {
          if (state is PostsAdditionSuccessState)
            {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Success'),
                    content: const Text('success add post'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              )
            }
          else
            {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Failed'),
                    content: const Text('Failed add post'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              )
            }
        },
        builder: (context, state) {
          if (state is PostsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostFetchingSuccessfulState) {
            return ListView.builder(
              itemCount: state.posts.length, // Example length, adjust as needed
              itemBuilder: (context, index) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [AppElevation.elevationPrimary],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.posts[index].title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Marwahal Hagai Excellent - 2010511072",
                            style: TextStyle(color: AppColors.gray700),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      "lib/resources/images/arrow-right.svg",
                      width: 30,
                    ),
                  ],
                ),
              ),
            );
          }
          return (Container());
        },
      ),
    );
  }
}
