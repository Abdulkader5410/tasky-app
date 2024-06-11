// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  int? id;
  String title, desc, image, proirity;
  String date;

  TaskEntity({
    this.id,
    required this.title,
    required this.desc,
    required this.image,
    required this.date,
    required this.proirity,
  });

  @override
  List<Object?> get props => [id, title, desc, image, proirity, date];
}
