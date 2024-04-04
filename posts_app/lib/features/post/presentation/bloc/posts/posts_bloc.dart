import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/core/strings/failure.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';
import 'package:posts_app/features/post/domain/usecase/get_all_post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPsotsUC getAllPsots;

  PostsBloc({required this.getAllPsots}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefershPageEvent) {
        emit(LoadingPostsState());

        final postsOrFailure = await getAllPsots();

        postsOrFailure.fold(
          (failure) {
            emit(ErrorPostsState(message: _mapFailureType(failure)));
          },
          (posts) {
            emit(LoadedPostsState(listPosts: posts));
          },
        );
      }
    });
  }



  String _mapFailureType(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case EmptyFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return SERVER_FAILURE_MESSAGE;

      default:
        return "Unexpcted Error";
    }
  }
}
