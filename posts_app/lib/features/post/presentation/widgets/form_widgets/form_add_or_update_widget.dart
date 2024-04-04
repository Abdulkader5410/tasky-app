import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';
import 'package:posts_app/features/post/presentation/bloc/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:posts_app/features/post/presentation/widgets/form_widgets/custom_button.dart';
import 'package:posts_app/features/post/presentation/widgets/form_widgets/custom_field.dart';

class FormAddOrUpdateWidget extends StatefulWidget {
  final bool isUpdatePost;
  final PostEntity? post;

  const FormAddOrUpdateWidget(
      {super.key, required this.isUpdatePost, required this.post});

  @override
  State<FormAddOrUpdateWidget> createState() => _FormAddOrUpdateWidgetState();
}

class _FormAddOrUpdateWidgetState extends State<FormAddOrUpdateWidget> {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isUpdatePost == true) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  void addOrUpdatePress() {
    final vaild = _keyForm.currentState!.validate();

    if (vaild) {
      final post = PostEntity(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: widget.post!.title,
          body: widget.post!.body);

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdateBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdateBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key: _keyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomField(
                      name: "Title",
                      multiLines: false,
                      controller: _titleController),
                  CustomField(
                      name: "Body",
                      multiLines: true,
                      controller: _bodyController),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 6,
                      decoration: const InputDecoration(hintText: "Add title"),
                      validator: (value) =>
                          value!.isEmpty ? "Title can't be empty" : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 6,
                      decoration: const InputDecoration(hintText: "Add body"),
                      validator: (value) =>
                          value!.isEmpty ? "Title can't be empty" : null,
                    ),
                  )
                ],
              )),
          CustomButton(
            addOrUpdatePress: addOrUpdatePress,
            text: widget.isUpdatePost ? "Update" : "Add",
          )
        ],
      ),
    );
  }
}
