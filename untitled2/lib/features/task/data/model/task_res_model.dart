import 'package:untitled2/features/task/data/model/task_model.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';

// ignore: must_be_immutable
class TaskResModel extends TaskResEntity {
  TaskResModel({
    super.id,
    required super.priority,
    required super.image,
    required super.desc,
    required super.status,
    required super.title,
    super.user,
  });

  factory TaskResModel.fromjson(Map<String, dynamic> jsonPro) {

    return TaskResModel(
      // title: jsonPro['title'],
      // images: List<String>.from(jsonPro['images']),
      // price: jsonPro['price'],
      // desc: jsonPro['description'],
      // categ: CategModel.fromjson(jsonPro['category']),
      id: jsonPro['_id'],
      priority: jsonPro['priority'],
      image: jsonPro['image'],
      desc: jsonPro['desc'],
      status: jsonPro['status'],
      title: jsonPro['title'],
      user: jsonPro['user'],
    );
  }
}
