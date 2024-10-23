import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/domain/model/post.dart';

abstract class PostsState {}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsErrorState extends PostsState {
  PostsErrorState({
    required this.error,
  });

  final FirebaseException error;
}

class PostsSuccessState extends PostsState {
  PostsSuccessState({
    required this.data,
  });

  final List<Post> data;
}
