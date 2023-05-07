import 'dart:async';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/apod_is_save.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/fetch_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_all_apod_save.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_by_date_range.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_from_date.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_random_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_today_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/remove_save_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/save_apod.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'apod_event.dart';
part 'apod_state.dart';

class ApodBloc {
  GetTodayApod getTodayApod;
  GetRandomApod getRandomApod;
  GetApodFromDate getApodFromDate;
  FetchApod fetchApod;
  GetApodByDateRange getApodByDateRange;
  ApodIsSave apodIsSave;
  GetAllApodSave getAllApodSave;
  RemoveSaveApod removeSaveApod;
  SaveApod saveApod;

  ApodBloc(
      {required this.getTodayApod,
      required this.getRandomApod,
      required this.getApodFromDate,
      required this.fetchApod,
      required this.getApodByDateRange,
      required this.apodIsSave,
      required this.getAllApodSave,
      required this.removeSaveApod,
      required this.saveApod}) {
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
    } else if (event is GetByDateRangeApodEvent) {
      getApodByDateRange(event.query).then((value) => value.fold(
          (l) => _outputController.add(ErrorApodState(msg: l.msg)),
          (r) => _outputController.add(SuccessListApodState(list: r))));
    } else if (event is IsSaveApodEvent) {
      apodIsSave(event.date).then((value) => value.fold(
          (l) => _outputController.add(ErrorApodState(msg: l.msg)),
          (r) => _outputController.add(IsSaveApodState(wasSave: r))));
    } else if (event is GetAllSaveApodEvent) {
      getAllApodSave(NoParameter()).then((value) => value.fold(
          (l) => _outputController.add(ErrorApodState(msg: l.msg)),
          (r) => _outputController.add(SuccessListApodState(list: r))));
    } else if (event is RemoveSaveApodEvent) {
      removeSaveApod(event.date).then((value) => value.fold(
          (l) => _outputController.add(ErrorApodState(msg: l.msg)),
          (r) =>
              _outputController.add(LocalAccessSuccessApodState(msg: r.msg))));
    } else if (event is SaveApodEvent) {
      saveApod(event.apod).then((value) => value.fold(
          (l) => _outputController.add(ErrorApodState(msg: l.msg)),
          (r) =>
              _outputController.add(LocalAccessSuccessApodState(msg: r.msg))));
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
