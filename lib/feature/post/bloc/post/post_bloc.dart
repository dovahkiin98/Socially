import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/repository.dart';

import 'post_event.dart';
import 'post_state.dart';

export 'post_event.dart';
export 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required Repository repository,
    required String postId,
  })  : _repository = repository,
        _postId = postId,
        super(PostInitialState()) {
    on<PostGetDataEvent>(_onGetData);
  }

  final Repository _repository;
  final String _postId;

  FutureOr<void> _onGetData(
    PostGetDataEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());

    try {
      final post = await _repository.getPost(_postId);

      emit(PostSuccessState(data: post));
    } on FirebaseException catch (e) {
      emit(PostErrorState(error: e));
    } on Exception catch (e) {
      print(e);
    }
  }
}
