import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cubit/logout_cubit/logout_cubit.dart';
import 'package:untitled2/features/splash_-screen.dart';
import 'package:untitled2/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:untitled2/features/task/presentation/ui/add_or_update_screen.dart';
import 'package:untitled2/features/task/presentation/ui/task_details_screen.dart';
import 'package:untitled2/features/task/presentation/widgets/task_widget.dart';
import 'package:untitled2/pages/profile/profile_page.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(const GetAllTasksEvent());

    return BlocBuilder<TaskBloc, TasksState>(
      builder: (context, state) {
        if (state is LoadingTasksState) {
          return Scaffold(
              body: Center(child: const CircularProgressIndicator()));
        } else if (state is ErrorTasksState) {
          return Text(state.message);
        } else if (state is LoadedTasksState) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AddOrUpdateScreen(isAdd: true, task: null),
                        ));
                  }),
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: RichText(
                    text: const TextSpan(
                        style: TextStyle(fontSize: 24),
                        children: [
                      TextSpan(
                          text: "Task",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: "y", style: TextStyle(color: Colors.yellow)),
                    ])),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      icon: const Icon(
                        Icons.person_rounded,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {
                        context.read<LogoutCubit>().logout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashPage(),
                            ));
                      },
                      icon: const Icon(Icons.logout_outlined,
                          color: Colors.deepPurple)),
                  const SizedBox(width: 0)
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 18),
                    child: Text("My Tasks"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceChip(
                            onSelected: (value) {
                              context.read<TaskBloc>().add(GetAllTasksEvent());
                            },
                            showCheckmark: false,
                            disabledColor: Colors.grey.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.1)),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(24))),
                            label: const Text("All"),
                            selectedColor: Colors.deepPurple,
                            selected: true),
                        ChoiceChip(
                            onSelected: (value) {
                              context.read<TaskBloc>().add(GetAllTasksEvent());
                            },
                            disabledColor: Colors.grey.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.1)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            label: const Text("InProgress"),
                            selected: false),
                        ChoiceChip(
                            onSelected: (value) {
                              context.read<TaskBloc>().add(GetAllTasksEvent());
                            },
                            disabledColor: Colors.grey.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.1)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            label: const Text("Waiting"),
                            selected: false),
                        ChoiceChip(
                            onSelected: (value) {
                              context.read<TaskBloc>().add(GetAllTasksEvent());
                            },
                            disabledColor: Colors.grey.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.1)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            label: const Text("Finished"),
                            selected: false),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.listTask.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskDetailsScreen(
                                        task: state.listTask[index]),
                                  ));
                            },
                            child:
                                TaskWidget(taskEntity: state.listTask[index]));
                      },
                    ),
                  ),
                ],
              ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

// Widget _buildBody() {
//   return Padding(
//     padding: const EdgeInsets.all(8),
//     child: BlocBuilder(
//       builder: (context, state) {
//         if (state is LoadingTasksState) {
//           return const LoadingWidget();
//         } else if (state is LoadedTasksState) {
//           return ListTaskWidget(tasks: state.listTask);
//         } else if (state is ErrorTasksState) {
//           return ErrorgWidget(message: state.message);
//         }
//         return const LoadingWidget();
//       },
//     ),
//   );
// }
