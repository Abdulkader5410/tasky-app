part of 'add_delete_update_bloc.dart';

sealed class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdateEvent {
  final PostEntity post;

  AddPostEvent({required this.post});
  @override
  List<Object> get props => [];
}

class DeletePostEvent extends AddDeleteUpdateEvent {
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [];
}

class UpdatePostEvent extends AddDeleteUpdateEvent {
  final PostEntity post;

  UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [];
}
