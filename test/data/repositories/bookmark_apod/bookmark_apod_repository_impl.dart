import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/data/datasources/bookmark_apod/bookmark_apod_data_source.dart';
import 'package:astronomy_picture/data/repositories/bookmark_apod/bookmark_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/bookmark_apod/bookmark_apod_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import 'bookmark_apod_repository_impl.mocks.dart';

@GenerateNiceMocks([MockSpec<BookmarkApodDataSource>()])
void main() {
  late MockBookmarkApodDataSource dataSource;
  late BookmarkApodRepository repository;

  setUp(() {
    dataSource = MockBookmarkApodDataSource();
    repository = BookmarkApodRepositoryImpl(bookmarkApodDataSource: dataSource);
  });

  group('function saveApod', () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      when(dataSource.saveApod(any)).thenAnswer((_) async => ApodSave());

      final result = await repository.saveApod(tApod());

      expect(result, Right<Failure, SuccessReturn>(ApodSave()));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(dataSource.saveApod(any)).thenThrow(SaveDataFailure());

      final result = await repository.saveApod(tApod());

      expect(result, Left<Failure, SuccessReturn>(SaveDataFailure()));
    });
  });

  group('function removeSaveApod', () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      when(dataSource.removeSaveApod(any)).thenAnswer((_) async => ApodSave());

      final result = await repository.removeSaveApod("date");

      expect(result, Right<Failure, SuccessReturn>(ApodSave()));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(dataSource.removeSaveApod(any)).thenThrow(RemoveDataFailure());

      final result = await repository.removeSaveApod("date");

      expect(result, Left<Failure, SuccessReturn>(RemoveDataFailure()));
    });
  });

  group('function apodIsSave', () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      when(dataSource.apodIsSave(any)).thenAnswer((_) async => true);

      final result = await repository.apodIsSave("date");

      expect(result, const Right<Failure, bool>(true));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(dataSource.apodIsSave(any)).thenThrow(AccessLocalDataFailure());

      final result = await repository.apodIsSave("date");

      expect(result, Left<Failure, bool>(AccessLocalDataFailure()));
    });
  });

  group('function getAllApodSave', () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      when(dataSource.getAllApodSave())
          .thenAnswer((_) async => tListApodModel());

      final result = await repository.getAllApodSave();

      result.fold((l) => fail("Test Failed"), (r) => expect(r, tListApod()));
    });

    test(
        "Should return an Failure throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(dataSource.getAllApodSave()).thenThrow(AccessLocalDataFailure());

      final result = await repository.getAllApodSave();

      expect(result, Left<Failure, List<Apod>>(AccessLocalDataFailure()));
    });
  });
}
