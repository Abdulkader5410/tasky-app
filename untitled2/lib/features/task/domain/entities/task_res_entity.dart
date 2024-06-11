import 'package:equatable/equatable.dart';
import 'package:untitled2/features/task/data/model/task_model.dart';

// ignore: must_be_immutable
class TaskResEntity extends Equatable {
  final String image, title, desc, priority, status;
  String? id, user;
  TaskResEntity({
    this.id,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
     this.user,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, desc, image, user, priority];
}
