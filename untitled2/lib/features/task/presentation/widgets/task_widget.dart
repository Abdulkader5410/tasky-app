import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled2/features/task/data/model/task_model.dart';
import 'package:untitled2/features/task/domain/entities/task_entity.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';

class TaskWidget extends StatelessWidget {
  final TaskResEntity taskEntity;

  const TaskWidget({super.key, required this.taskEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      width: MediaQuery.sizeOf(context).width,
      child: ListTile(
        horizontalTitleGap: 20,
        isThreeLine: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                taskEntity.title,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  taskEntity.status,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    taskEntity.desc,
                    style: const TextStyle(
                        color: Colors.grey, overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.flag_outlined,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(taskEntity.priority,
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      taskEntity.title,
                      textAlign: TextAlign.right,
                    )),
              ],
            )
          ],
        ),
        leading: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.card_travel,
              size: 30,
            ),
          ],
        ),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}