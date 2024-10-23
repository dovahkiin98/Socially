import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/repository.dart';

import 'posts_event.dart';
import 'posts_state.dart';

export 'posts_event.dart';
export 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc(
    Repository repository,
  )   : _repository = repository,
        super(PostsInitialState()) {
    on<PostsGetDataEvent>(_onGetData);
  }

  final Repository _repository;

  FutureOr<void> _onGetData(
    PostsGetDataEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoadingState());

    try {
      final posts = await _repository.getPosts();

      emit(PostsSuccessState(data: posts));
    } on FirebaseException catch (e) {
      emit(PostsErrorState(error: e));
    } on Exception catch (e) {
      print(e);
    }
  }
}
