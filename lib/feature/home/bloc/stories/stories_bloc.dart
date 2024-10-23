import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/repository.dart';

import 'stories_event.dart';
import 'stories_state.dart';

export 'stories_event.dart';
export 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  StoriesBloc(
    Repository repository,
  )   : _repository = repository,
        super(StoriesInitialState()) {
    on<StoriesGetDataEvent>(_onGetData);
  }

  final Repository _repository;

  FutureOr<void> _onGetData(
    StoriesGetDataEvent event,
    Emitter<StoriesState> emit,
  ) async {
    emit(StoriesLoadingState());

    try {
      final stories = await _repository.getStories();

      emit(StoriesSuccessState(data: stories));
    } on FirebaseException catch (e) {
      emit(StoriesErrorState(error: e));
    } on Exception catch (e) {
      print(e);
    }
  }
}
