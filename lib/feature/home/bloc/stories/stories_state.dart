import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/domain/model/story.dart';

abstract class StoriesState {}

class StoriesInitialState extends StoriesState {}

class StoriesLoadingState extends StoriesState {}

class StoriesErrorState extends StoriesState {
  StoriesErrorState({
    required this.error,
  });

  final FirebaseException error;
}

class StoriesSuccessState extends StoriesState {
  StoriesSuccessState({
    required this.data,
  });

  final List<Story> data;
}
