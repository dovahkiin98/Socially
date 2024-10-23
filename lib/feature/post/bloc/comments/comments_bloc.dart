import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/repository.dart';

import 'comments_event.dart';
import 'comments_state.dart';

export 'comments_event.dart';
export 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({
    required Repository repository,
    required String postId,
  })  : _repository = repository,
        _postId = postId,
        super(CommentsInitialState()) {
    on<CommentsGetDataEvent>(_onGetData);
  }

  final Repository _repository;
  final String _postId;

  FutureOr<void> _onGetData(
    CommentsGetDataEvent event,
    Emitter<CommentsState> emit,
  ) async {
    emit(CommentsLoadingState());

    try {
      final comments = await _repository.getComments(_postId);

      emit(CommentsSuccessState(data: comments));
    } on FirebaseException catch (e) {
      emit(CommentsErrorState(error: e));
    } on Exception catch (e) {
      print(e);
    }
  }
}
