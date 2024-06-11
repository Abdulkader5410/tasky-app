// ignore_for_file: must_be_immutable

import 'package:untitled2/features/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel(
      {int? id,
      required String title,
      required String desc,
      required String proirity,
      required String date,
      required String image})
      : super(
            id: id,
            title: title,
            desc: desc,
            date: date,
            image: image,
            proirity: proirity,
          );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    //not compelete
    return TaskModel(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      image: json['image'],
      date: json['dueDate'],
      proirity: json['priority'],
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'image': image,
      'dueDate': date,
      'priority': proirity,
    };
  }
}
