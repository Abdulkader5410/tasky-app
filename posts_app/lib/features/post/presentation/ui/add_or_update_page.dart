import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/utilities/snakBar.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';
import 'package:posts_app/features/post/presentation/bloc/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:posts_app/features/post/presentation/ui/post_page.dart';
import 'package:posts_app/features/post/presentation/widgets/form_widgets/form_add_or_update_widget.dart';

class AddOrUpdatePage extends StatelessWidget {
  final PostEntity? postEntity;
  final bool isUpdatePost;

  const AddOrUpdatePage(
      {super.key, this.postEntity, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
      builder: (context, state) {
        if (state is ErrorAddDeleteUpdateState) {
          ShowSnakBar().ErrorSnakBar(context: context, message: state.message);
        } else if (state is MessageAddDeleteUpdateState) {
          ShowSnakBar()
              .MessageSnakBar(context: context, message: state.message);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PostPage(),
              ));
        } else if (state is LoadingAddDeleteUpdateState) {
          return const LoadingWidget();
        }
        return  FormAddOrUpdateWidget(isUpdatePost: isUpdatePost , post: isUpdatePost? postEntity : null);
      },
      listener: (context, state) {

      },
    );
  }
}
