import 'package:flutter/material.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';

class ListTaskWidget extends StatelessWidget {
  final List<TaskEntity> tasks;

  const ListTaskWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(tasks[index].id.toString(), ),
            title: Text(tasks[index].title.toString(), ),
            subtitle: Text(tasks[index].desc.toString(), ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: tasks.length);
  }
}
