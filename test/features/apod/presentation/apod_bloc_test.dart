import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_from_date.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_random_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_today_apod.dart';
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
  MockSpec<GetApodFromDate>()
])
void main() {
  late MockGetTodayApod getTodayApod;
  late MockGetRandomApod getRandomApod;
  late MockGetApodFromDate getApodFromDate;
  late ApodBloc apodBloc;

  setUp(() {
    getTodayApod = MockGetTodayApod();
    getRandomApod = MockGetRandomApod();
    getApodFromDate = MockGetApodFromDate();
    apodBloc = ApodBloc(
        getTodayApod: getTodayApod,
        getRandomApod: getRandomApod,
        getApodFromDate: getApodFromDate);
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
}
