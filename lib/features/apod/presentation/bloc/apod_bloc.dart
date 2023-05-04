import 'dart:async';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/fetch_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_from_date.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_random_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_today_apod.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'apod_event.dart';
part 'apod_state.dart';

class ApodBloc {
  GetTodayApod getTodayApod;
  GetRandomApod getRandomApod;
  GetApodFromDate getApodFromDate;
  FetchApod fetchApod;

  ApodBloc(
      {required this.getTodayApod,
      required this.getRandomApod,
      required this.getApodFromDate,
      required this.fetchApod}) {
    _inputController.stream.listen(_mapEventToState);
  }

  final StreamController<ApodEvent> _inputController =
      StreamController<ApodEvent>();
  final StreamController<ApodState> _outputController =
      StreamController<ApodState>();

  Sink<ApodEvent> get input => _inputController.sink;
  Stream<ApodState> get stream => _outputController.stream;

  void _mapEventToState(ApodEvent event) {
    _outputController.add(LoadingApodState());

    if (event is FetchApodEvent) {
      fetchApod(NoParameter()).then((value) => value.fold(
          (l) => _outputController.add(ErrorApodState(msg: l.msg)),
          (r) => _outputController.add(SuccessListApodState(list: r))));
    } else {
      late Future<Either<Failure, Apod>> Function() useCase;

      if (event is GetTodayApodEvent) {
        useCase = () => getTodayApod(NoParameter());
      }

      if (event is GetRandomApodEvent) {
        useCase = () => getRandomApod(NoParameter());
      }

      if (event is GetApodFromDateEvent) {
        useCase = () => getApodFromDate(event.date);
      }

      useCase().then((value) => value.fold(
          (l) => _outputController.add(ErrorApodState(msg: l.msg)),
          (r) => _outputController.add(SuccessApodState(apod: r))));
    }
  }
}
