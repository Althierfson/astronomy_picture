import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_local_data_source.dart';
import 'package:astronomy_picture/features/apod/data/repositories/apod_local_repository_impl.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../teste_values.dart';
import 'apod_local_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApodLocalDataSource>()])
void main() {
  late MockApodLocalDataSource localDataSource;
  late ApodLocalRepositoryImpl repository;

  setUp(() {
    localDataSource = MockApodLocalDataSource();
    repository = ApodLocalRepositoryImpl(localDataSource: localDataSource);
  });

  group('function saveApod', () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      when(localDataSource.saveApod(any)).thenAnswer((_) async => ApodSave());

      final result = await repository.saveApod(tApod());

      expect(result, Right<Failure, SuccessReturn>(ApodSave()));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(localDataSource.saveApod(any)).thenThrow(SaveDataFailure());

      final result = await repository.saveApod(tApod());

      expect(result, Left<Failure, SuccessReturn>(SaveDataFailure()));
    });
  });

  group('function removeSaveApod', () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      when(localDataSource.removeSaveApod(any))
          .thenAnswer((_) async => ApodSave());

      final result = await repository.removeSaveApod("date");

      expect(result, Right<Failure, SuccessReturn>(ApodSave()));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(localDataSource.removeSaveApod(any)).thenThrow(RemoveDataFailure());

      final result = await repository.removeSaveApod("date");

      expect(result, Left<Failure, SuccessReturn>(RemoveDataFailure()));
    });
  });

  group('function apodIsSave', () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      when(localDataSource.apodIsSave(any)).thenAnswer((_) async => true);

      final result = await repository.apodIsSave("date");

      expect(result, const Right<Failure, bool>(true));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(localDataSource.apodIsSave(any)).thenThrow(AccessLocalDataFailure());

      final result = await repository.apodIsSave("date");

      expect(result, Left<Failure, bool>(AccessLocalDataFailure()));
    });
  });

  group('function getAllApodSave', () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      when(localDataSource.getAllApodSave())
          .thenAnswer((_) async => tListApodModel());

      final result = await repository.getAllApodSave();

      result.fold((l) => fail("Test Failed"), (r) => expect(r, tListApod()));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(localDataSource.getAllApodSave())
          .thenThrow(AccessLocalDataFailure());

      final result = await repository.getAllApodSave();

      expect(result, Left<Failure, List<Apod>>(AccessLocalDataFailure()));
    });
  });

  group('function fetchSearchHistory', () {
    test("Should return a List of String on the Right side of Either",
        () async {
      when(localDataSource.getSearchHistory())
          .thenAnswer((_) async => tHistoryList());

      final result = await repository.fetchSearchHistory();

      result.fold((l) => fail("Test Failed"), (r) => expect(r, tHistoryList()));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(localDataSource.getSearchHistory())
          .thenThrow(AccessLocalDataFailure());

      final result = await repository.fetchSearchHistory();

      expect(result, Left<Failure, List<String>>(AccessLocalDataFailure()));
    });
  });

  group('function updateSearchHistory', () {
    test("Should return a List of String on the Right side of Either",
        () async {
      when(localDataSource.updateSearchHistory(any))
          .thenAnswer((_) async => tHistoryList());

      final result = await repository.updateSearchHistory(tHistoryList());

      result.fold((l) => fail("Test Failed"), (r) => expect(r, tHistoryList()));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(localDataSource.updateSearchHistory(any))
          .thenThrow(AccessLocalDataFailure());

      final result = await repository.updateSearchHistory(tHistoryList());

      expect(result, Left<Failure, List<String>>(AccessLocalDataFailure()));
    });
  });
}
