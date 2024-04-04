import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/app_theme/app_theme.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app/features/post/presentation/ui/add_or_update_page.dart';
import 'package:posts_app/features/post/presentation/widgets/error_widget.dart';
import 'package:posts_app/features/post/presentation/widgets/list_post_widget.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.add,
            color: secondaryColor,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AddOrUpdatePage(isUpdatePost: false),
                ));
          }),
      appBar: AppBar(
          title: const Text(
        "Post Page",
        style: styleTitles,
      )),
      body: _buildBody(),
    );
  }
}

Widget _buildBody() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: BlocBuilder(
      builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          return ListPostWidget(posts: state.listPosts);
        } else if (state is ErrorPostsState) {
          return ErrorgWidget(message: state.message);
        }
        return const LoadingWidget();
      },
    ),
  );
}
