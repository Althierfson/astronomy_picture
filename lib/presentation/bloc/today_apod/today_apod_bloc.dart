import 'dart:async';

import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/get_today_apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:equatable/equatable.dart';

part 'today_apod_event.dart';
part 'today_apod_state.dart';

class TodayApodBloc {
  GetTodayApod todayApod;

  TodayApodBloc({required this.todayApod}) {
    _inputController.stream.listen(_mapEventToState);
  }

  final StreamController<TodayApodEvent> _inputController =
      StreamController<TodayApodEvent>();
  final StreamController<TodayApodState> _outputController =
      StreamController<TodayApodState>();

  Sink<TodayApodEvent> get input => _inputController.sink;
  Stream<TodayApodState> get stream => _outputController.stream;

  void _mapEventToState(TodayApodEvent event) {
    _outputController.add(LoadingTodayApodState());

    if (event is GetTodayApodEvent) {
      todayApod(NoParameter()).then((value) => value.fold(
          (l) => _outputController.add(ErrorTodayApodState(msg: l.msg)),
          (r) => _outputController.add(SuccessTodayApodState(apod: r))));
    }
  }
}
