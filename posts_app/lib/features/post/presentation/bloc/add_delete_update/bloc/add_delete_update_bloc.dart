import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/core/strings/failure.dart';
import 'package:posts_app/core/strings/messages.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';
import 'package:posts_app/features/post/domain/usecase/add_post.dart';
import 'package:posts_app/features/post/domain/usecase/delete_post.dart';
import 'package:posts_app/features/post/domain/usecase/update_post.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUC addPost;
  final DeletePostUC deletePost;
  final UpdatePostUC updatePost;

  AddDeleteUpdateBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdateState());

        final messageOrFailure = await addPost(event.post);
        emit(_eitherMessageOrFailure(messageOrFailure, ADD_SUCCESSFUL_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdateState());

        final messageOrFailure = await updatePost(event.post);
        emit(_eitherMessageOrFailure(
            messageOrFailure, UPDATE_SUCCESSFUL_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdateState());

        final messageOrFailure = await deletePost(event.postId);

        emit(_eitherMessageOrFailure(
            messageOrFailure, DELETE_SUCCESSFUL_MESSAGE));
      }
    });
  }

  AddDeleteUpdateState _eitherMessageOrFailure(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateState(message: _mapFailureType(failure)),
      (posts) => MessageAddDeleteUpdateState(message: message),
    );
  }

  String _mapFailureType(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return SERVER_FAILURE_MESSAGE;

      default:
        return "Unexpcted Error";
    }
  }
}
