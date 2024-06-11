import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';
import 'package:untitled2/features/task/presentation/bloc/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:untitled2/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:untitled2/features/task/presentation/ui/add_or_update_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskResEntity task;
  const TaskDetailsScreen({super.key, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  String? selectedItem;
  String? selectedItem2;

  List<PopupMenuEntry<String>> menuItems = <PopupMenuEntry<String>>[
    const PopupMenuItem(value: 'edit', child: Text("Edit")),
    PopupMenuDivider(),
    const PopupMenuItem(value: 'delete', child: const Text("Delete"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Task Details",
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddOrUpdateScreen(
                              task: widget.task, isAdd: false)));
                  break;
                case 'delete':
                  context
                      .read<AddDeleteUpdateBloc>()
                      .add(DeleteTaskEvent(taskId: "${widget.task.id}"));
                      Navigator.pop(context);
                  break;
              }
            },
            itemBuilder: (context) {
              return menuItems;
            },
          )
        ],
      ),
      body: BlocBuilder<TaskBloc, TasksState>(
        builder: (context, state) {
          if (state is LoadingTasksState) {
            return const CircularProgressIndicator();
          } else if (state is LoadedTasksState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add_task_sharp,
                        size: 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        widget.task.title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        widget.task.desc,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.deepPurple.withOpacity(0.1),
                        title: const Text(
                          "Date",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        subtitle: Text(
                          widget.task.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        trailing: const Icon(
                          Icons.date_range,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: null),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                )),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                )),
                          ),
                          iconDisabledColor: Colors.deepPurple,
                          iconSize: 30,
                          hint: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Colors.deepPurple,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.task.status,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          value: selectedItem,
                          items: <String>['inProgress', 'waiting', 'finished']
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.w700),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            selectedItem = value;

                            print("VALUE >>>>>> $selectedItem");
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: null),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                )),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                )),
                          ),
                          iconDisabledColor: Colors.deepPurple,
                          iconSize: 30,
                          hint: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.flag_outlined,
                                color: Colors.deepPurple,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Middle",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          value: selectedItem2,
                          items: <String>['High', 'Middle', 'Low']
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem(
                                value: val,
                                child: Row(
                                  children: [
                                    const Icon(Icons.flag_outlined),
                                    Text(
                                      val,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (value) {
                            selectedItem2 = value;
                            print("VALUE >>>>>> $selectedItem");
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 180,
                              width: 180,
                              child: QrImageView(data: '''Title : ${widget.task.title}\nDescription : ${widget.task.desc}\nPriority : ${widget.task.priority}\nStatus : ${widget.task.status}'''))),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
