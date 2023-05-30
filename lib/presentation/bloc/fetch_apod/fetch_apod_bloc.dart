import 'dart:async';

import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usecases/fetch_apod/fetch_apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:equatable/equatable.dart';

part 'fetch_apod_event.dart';
part 'fetch_apod_state.dart';

class FetchApodBloc {
  FetchApod fetchApod;

  FetchApodBloc({required this.fetchApod}) {
    _inputController.stream.listen(_mapEventToState);
  }

  final StreamController<FetchApodEvent> _inputController =
      StreamController<FetchApodEvent>();
  final StreamController<FetchApodState> _outputController =
      StreamController<FetchApodState>();

  Sink<FetchApodEvent> get input => _inputController.sink;
  Stream<FetchApodState> get stream => _outputController.stream;

  void _mapEventToState(FetchApodEvent event) {
    _outputController.add(LoadingFetchApodState());

    if (event is MakeFetchApodEvent) {
      fetchApod(NoParameter()).then((value) => value.fold(
          (l) => _outputController.add(ErrorFetchApodState(msg: l.msg)),
          (r) => _outputController.add(SuccessListFetchApod(list: r))));
    }
  }
}
