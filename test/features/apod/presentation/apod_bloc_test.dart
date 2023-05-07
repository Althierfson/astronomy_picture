import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/apod_is_save.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/fetch_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_all_apod_save.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_by_date_range.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_from_date.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_random_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_today_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/remove_save_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/save_apod.dart';
import 'package:astronomy_picture/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import 'apod_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetTodayApod>(),
  MockSpec<GetRandomApod>(),
  MockSpec<GetApodFromDate>(),
  MockSpec<FetchApod>(),
  MockSpec<GetApodByDateRange>(),
  MockSpec<ApodIsSave>(),
  MockSpec<GetAllApodSave>(),
  MockSpec<RemoveSaveApod>(),
  MockSpec<SaveApod>(),
])
void main() {
  late MockGetTodayApod getTodayApod;
  late MockGetRandomApod getRandomApod;
  late MockGetApodFromDate getApodFromDate;
  late MockFetchApod fetchApod;
  late MockGetApodByDateRange getApodByDateRange;
  late MockApodIsSave apodIsSave;
  late MockGetAllApodSave getAllApodSave;
  late MockRemoveSaveApod removeSaveApod;
  late MockSaveApod saveApod;
  late ApodBloc apodBloc;

  setUp(() {
    getTodayApod = MockGetTodayApod();
    getRandomApod = MockGetRandomApod();
    getApodFromDate = MockGetApodFromDate();
    fetchApod = MockFetchApod();
    getApodByDateRange = MockGetApodByDateRange();
    apodIsSave = MockApodIsSave();
    getAllApodSave = MockGetAllApodSave();
    removeSaveApod = MockRemoveSaveApod();
    saveApod = MockSaveApod();
    apodBloc = ApodBloc(
        getTodayApod: getTodayApod,
        getRandomApod: getRandomApod,
        getApodFromDate: getApodFromDate,
        fetchApod: fetchApod,
        getApodByDateRange: getApodByDateRange,
        apodIsSave: apodIsSave,
        getAllApodSave: getAllApodSave,
        removeSaveApod: removeSaveApod,
        saveApod: saveApod);
  });

  final tSuccessStremList = [
    LoadingApodState(),
    SuccessApodState(apod: tApod())
  ];

  final tApiFailureStremList = [
    LoadingApodState(),
    const ErrorApodState(msg: "Sorry! It was not possible to access the Server")
  ];

  final tNoConnectionStremList = [
    LoadingApodState(),
    const ErrorApodState(msg: "Sorry! You not have connection!")
  ];

  group("usecase - GetTodayApod", () {
    test("Should emit LoadingApodState and SuccessApodState", () {
      when(getTodayApod(any)).thenAnswer((_) async => Right(tApod()));

      apodBloc.input.add(GetTodayApodEvent());

      expect(apodBloc.stream, emitsInOrder(tSuccessStremList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getTodayApod(any)).thenAnswer((_) async => Left(ApiFailure()));

      apodBloc.input.add(GetTodayApodEvent());

      expect(apodBloc.stream, emitsInOrder(tApiFailureStremList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getTodayApod(any)).thenAnswer((_) async => Left(NoConnection()));

      apodBloc.input.add(GetTodayApodEvent());

      expect(apodBloc.stream, emitsInOrder(tNoConnectionStremList));
    });
  });

  group("usecase - GetRandomApod", () {
    test("Should emit LoadingApodState and SuccessApodState", () {
      when(getRandomApod(any)).thenAnswer((_) async => Right(tApod()));

      apodBloc.input.add(GetRandomApodEvent());

      expect(apodBloc.stream, emitsInOrder(tSuccessStremList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getRandomApod(any)).thenAnswer((_) async => Left(ApiFailure()));

      apodBloc.input.add(GetRandomApodEvent());

      expect(apodBloc.stream, emitsInOrder(tApiFailureStremList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getRandomApod(any)).thenAnswer((_) async => Left(NoConnection()));

      apodBloc.input.add(GetRandomApodEvent());

      expect(apodBloc.stream, emitsInOrder(tNoConnectionStremList));
    });
  });

  group("usecase - GetApodFromDate", () {
    final tGetApodFromDateEvent = GetApodFromDateEvent(date: tDateTime());
    test("Should emit LoadingApodState and SuccessApodState", () {
      when(getApodFromDate(any)).thenAnswer((_) async => Right(tApod()));

      apodBloc.input.add(tGetApodFromDateEvent);

      expect(apodBloc.stream, emitsInOrder(tSuccessStremList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getApodFromDate(any)).thenAnswer((_) async => Left(ApiFailure()));

      apodBloc.input.add(tGetApodFromDateEvent);

      expect(apodBloc.stream, emitsInOrder(tApiFailureStremList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getApodFromDate(any)).thenAnswer((_) async => Left(NoConnection()));

      apodBloc.input.add(tGetApodFromDateEvent);

      expect(apodBloc.stream, emitsInOrder(tNoConnectionStremList));
    });
  });

  group("usecase - FetchApod", () {
    final tSuccessStremApodList = [
      LoadingApodState(),
      SuccessListApodState(list: tListApod())
    ];
    test("Should emit LoadingApodState and SuccessListApodState", () {
      when(fetchApod(any)).thenAnswer((_) async => Right(tListApod()));

      apodBloc.input.add(FetchApodEvent());

      expect(apodBloc.stream, emitsInOrder(tSuccessStremApodList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(fetchApod(any)).thenAnswer((_) async => Left(ApiFailure()));

      apodBloc.input.add(FetchApodEvent());

      expect(apodBloc.stream, emitsInOrder(tApiFailureStremList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(fetchApod(any)).thenAnswer((_) async => Left(NoConnection()));

      apodBloc.input.add(FetchApodEvent());

      expect(apodBloc.stream, emitsInOrder(tNoConnectionStremList));
    });
  });

  group("usecase - GetByDateRangeApodEvent", () {
    final tSuccessStremApodList = [
      LoadingApodState(),
      SuccessListApodState(list: tListApod())
    ];
    test("Should emit LoadingApodState and SuccessListApodState", () {
      when(getApodByDateRange(any)).thenAnswer((_) async => Right(tListApod()));

      apodBloc.input.add(const GetByDateRangeApodEvent(query: "Query"));

      expect(apodBloc.stream, emitsInOrder(tSuccessStremApodList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getApodByDateRange(any)).thenAnswer((_) async => Left(ApiFailure()));

      apodBloc.input.add(const GetByDateRangeApodEvent(query: "Query"));

      expect(apodBloc.stream, emitsInOrder(tApiFailureStremList));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getApodByDateRange(any))
          .thenAnswer((_) async => Left(NoConnection()));

      apodBloc.input.add(const GetByDateRangeApodEvent(query: "Query"));

      expect(apodBloc.stream, emitsInOrder(tNoConnectionStremList));
    });
  });

  group("usecase - ApodIsSave", () {
    test("Should emit LoadingApodState and IsSaveApodState", () {
      when(apodIsSave(any)).thenAnswer((_) async => const Right(true));

      apodBloc.input.add(const IsSaveApodEvent(date: "date"));

      expect(
          apodBloc.stream,
          emitsInOrder(
              [LoadingApodState(), const IsSaveApodState(wasSave: true)]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(apodIsSave(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      apodBloc.input.add(const IsSaveApodEvent(date: "date"));

      expect(
          apodBloc.stream,
          emitsInOrder([
            LoadingApodState(),
            ErrorApodState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("usecase - getAllApodSave", () {
    test("Should emit LoadingApodState and SuccessListApodState", () {
      when(getAllApodSave(any)).thenAnswer((_) async => Right(tListApod()));

      apodBloc.input.add(GetAllSaveApodEvent());

      expect(
          apodBloc.stream,
          emitsInOrder(
              [LoadingApodState(), SuccessListApodState(list: tListApod())]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(apodIsSave(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      apodBloc.input.add(const IsSaveApodEvent(date: "date"));

      expect(
          apodBloc.stream,
          emitsInOrder([
            LoadingApodState(),
            ErrorApodState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("usecase - removeSaveApod", () {
    test("Should emit LoadingApodState and RemoveSaveApodEvent", () {
      when(removeSaveApod(any))
          .thenAnswer((_) async => Right(ApodSaveRemoved()));

      apodBloc.input.add(const RemoveSaveApodEvent(date: "date"));

      expect(
          apodBloc.stream,
          emitsInOrder([
            LoadingApodState(),
            LocalAccessSuccessApodState(msg: ApodSaveRemoved().msg)
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(removeSaveApod(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      apodBloc.input.add(const RemoveSaveApodEvent(date: "date"));

      expect(
          apodBloc.stream,
          emitsInOrder([
            LoadingApodState(),
            ErrorApodState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("usecase - saveApod", () {
    test("Should emit LoadingApodState and LocalAccessSuccessApodState", () {
      when(saveApod(any))
          .thenAnswer((_) async => Right(ApodSave()));

      apodBloc.input.add(SaveApodEvent(apod: tApod()));

      expect(
          apodBloc.stream,
          emitsInOrder([
            LoadingApodState(),
            LocalAccessSuccessApodState(msg: ApodSave().msg)
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(saveApod(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      apodBloc.input.add(SaveApodEvent(apod: tApod()));

      expect(
          apodBloc.stream,
          emitsInOrder([
            LoadingApodState(),
            ErrorApodState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });
}
