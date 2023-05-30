import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/fetch_apod/fetch_apod.dart';
import 'package:astronomy_picture/presentation/bloc/fetch_apod/fetch_apod_bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../teste_values.dart';
import 'home_apod_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FetchApod>(),
])
void main() {
  late FetchApodBloc homeApodBloc;
  late MockFetchApod fetchApod;

  setUp(() {
    fetchApod = MockFetchApod();
    homeApodBloc = FetchApodBloc(fetchApod: fetchApod);
  });

  group("usecase - FetchApod", () {
    test("Should emit LoadingApodState and SuccessListApodState", () {
      when(fetchApod(any)).thenAnswer((_) async => Right(tListApod()));

      homeApodBloc.input.add(MakeFetchApodEvent());

      expect(
          homeApodBloc.stream,
          emitsInOrder([
            LoadingFetchApodState(),
            SuccessListFetchApod(list: tListApod())
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(fetchApod(any)).thenAnswer((_) async => Left(ApiFailure()));

      homeApodBloc.input.add(MakeFetchApodEvent());

      expect(
          homeApodBloc.stream,
          emitsInOrder([
            LoadingFetchApodState(),
            ErrorFetchApodState(msg: ApiFailure().msg)
          ]));
    });
  });
}
