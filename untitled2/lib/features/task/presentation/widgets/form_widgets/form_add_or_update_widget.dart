// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled2/features/task/domain/entities/task_entity.dart';

// class FormAddOrUpdateWidget extends StatefulWidget {
//   final bool isUpdatePost;
//   final TaskEntity? task;

//   const FormAddOrUpdateWidget(
//       {super.key, required this.isUpdatePost, required this.task});

//   @override
//   State<FormAddOrUpdateWidget> createState() => _FormAddOrUpdateWidgetState();
// }

// class _FormAddOrUpdateWidgetState extends State<FormAddOrUpdateWidget> {
//   final _keyForm = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _bodyController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     if (widget.isUpdatePost == true) {
//       _titleController.text = widget.task!.title;
//       _bodyController.text = widget.task!.body;
//     }
//   }

//   void addOrUpdatePress() {
//     final vaild = _keyForm.currentState!.validate();

//     if (vaild) {
//       final post = PostEntity(
//           id: widget.isUpdatePost ? widget.post!.id : null,
//           title: widget.post!.title,
//           body: widget.post!.body);

//       if (widget.isUpdatePost) {
//         BlocProvider.of<AddDeleteUpdateBloc>(context)
//             .add(UpdatePostEvent(post: post));
//       } else {
//         BlocProvider.of<AddDeleteUpdateBloc>(context)
//             .add(AddPostEvent(post: post));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Form(
//               key: _keyForm,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CustomField(
//                       name: "Title",
//                       multiLines: false,
//                       controller: _titleController),
//                   CustomField(
//                       name: "Body",
//                       multiLines: true,
//                       controller: _bodyController),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: TextFormField(
//                       maxLines: 6,
//                       minLines: 6,
//                       decoration: const InputDecoration(hintText: "Add title"),
//                       validator: (value) =>
//                           value!.isEmpty ? "Title can't be empty" : null,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: TextFormField(
//                       maxLines: 6,
//                       minLines: 6,
//                       decoration: const InputDecoration(hintText: "Add body"),
//                       validator: (value) =>
//                           value!.isEmpty ? "Title can't be empty" : null,
//                     ),
//                   )
//                 ],
//               )),
//           CustomButton(
//             addOrUpdatePress: addOrUpdatePress,
//             text: widget.isUpdatePost ? "Update" : "Add",
//           )
//         ],
//       ),
//     );
//   }
// }
