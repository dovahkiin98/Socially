import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/domain/model/comment.dart';

abstract class CommentsState {}

class CommentsInitialState extends CommentsState {}

class CommentsLoadingState extends CommentsState {}

class CommentsErrorState extends CommentsState {
  CommentsErrorState({
    required this.error,
  });

  final FirebaseException error;
}

class CommentsSuccessState extends CommentsState {
  CommentsSuccessState({
    required this.data,
  });

  final List<Comment> data;
}
