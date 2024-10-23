import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/domain/model/post.dart';

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostErrorState extends PostState {
  PostErrorState({
    required this.error,
  });

  final FirebaseException error;
}

class PostSuccessState extends PostState {
  PostSuccessState({
    required this.data,
  });

  final Post data;
}
