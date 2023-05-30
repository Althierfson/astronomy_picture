import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/get_today_apod.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../teste_values.dart';
import 'today_apod_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetTodayApod>()])
void main() {
  late MockGetTodayApod getTodayApod;
  late TodayApodBloc bloc;

  setUp(() {
    getTodayApod = MockGetTodayApod();
    bloc = TodayApodBloc(todayApod: getTodayApod);
  });

  group("usecase - GetTodayApod", () {
    test("Should emit LoadingApodState and SuccessApodState", () {
      when(getTodayApod(any)).thenAnswer((_) async => Right(tApod()));

      bloc.input.add(GetTodayApodEvent());

      expect(
          bloc.stream,
          emitsInOrder(
              [LoadingTodayApodState(), SuccessTodayApodState(apod: tApod())]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getTodayApod(any)).thenAnswer((_) async => Left(ApiFailure()));

      bloc.input.add(GetTodayApodEvent());

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingTodayApodState(),
            ErrorTodayApodState(msg: ApiFailure().msg)
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getTodayApod(any)).thenAnswer((_) async => Left(NoConnection()));

      bloc.input.add(GetTodayApodEvent());

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingTodayApodState(),
            ErrorTodayApodState(msg: NoConnection().msg)
          ]));
    });
  });
}
