import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/comment.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final FirestoreRepository _firestoreRepository;

  CommentsCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(CommentsInitial());

  void emitCommentsInitial() => emit(CommentsInitial());

  void emitCommentsLoading({required Activity activity, int? limit}) {
    emit(CommentsLoading());

    emitCommentsLoaded(activity: activity, limit: limit);
  }

  Future<void> emitCommentsLoaded(
      {required Activity activity, int? limit}) async {
    String path = '$ACTIVITIES/${activity.activityUid}/$COMMENTS';

    final List<Comment> comments =
        await _firestoreRepository.getComments(path: path, limit: limit);

    emit(CommentsLoaded(comments: comments));
  }
}
