import 'dart:async';

import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/apod_is_save.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/get_all_apod_save.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/remove_save_apod.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/save_apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:equatable/equatable.dart';

part 'bookmark_apod_event.dart';
part 'bookmark_apod_state.dart';

class BookmarkApodBloc {
  ApodIsSave apodIsSave;
  GetAllApodSave getAllApodSave;
  RemoveSaveApod removeSaveApod;
  SaveApod saveApod;

  BookmarkApodBloc(
      {required this.apodIsSave,
      required this.getAllApodSave,
      required this.removeSaveApod,
      required this.saveApod}) {
    _inputController.stream.listen(_mapEventToState);
  }

  final StreamController<BookmarkApodEvent> _inputController =
      StreamController<BookmarkApodEvent>();
  final StreamController<BookmarkApodState> _outputController =
      StreamController<BookmarkApodState>();

  Sink<BookmarkApodEvent> get input => _inputController.sink;
  Stream<BookmarkApodState> get stream => _outputController.stream;

  void _mapEventToState(BookmarkApodEvent event) {
    _outputController.add(LoadingBookmarkApodState());

    if (event is IsSaveBookmarkApodEvent) {
      apodIsSave(event.date).then((value) => value.fold(
          (l) => _outputController.add(ErrorBookmarkApodState(msg: l.msg)),
          (r) => _outputController.add(IsSaveBookmarkApodState(wasSave: r))));
    }

    if (event is GetAllSaveBookmarkApodEvent) {
      getAllApodSave(NoParameter()).then((value) => value.fold(
          (l) => _outputController.add(ErrorBookmarkApodState(msg: l.msg)),
          (r) => _outputController.add(SuccessListBookmarkApodState(list: r))));
    }

    if (event is RemoveSaveBookmarkApodEvent) {
      removeSaveApod(event.date).then((value) => value.fold(
          (l) => _outputController.add(ErrorBookmarkApodState(msg: l.msg)),
          (r) => _outputController
              .add(LocalAccessSuccessBookmarkApodState(msg: r.msg))));
    }

    if (event is SaveBookmarkApodEvent) {
      saveApod(event.apod).then((value) => value.fold(
          (l) => _outputController.add(ErrorBookmarkApodState(msg: l.msg)),
          (r) => _outputController
              .add(LocalAccessSuccessBookmarkApodState(msg: r.msg))));
    }
  }
}
