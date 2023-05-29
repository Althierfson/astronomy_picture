import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_local_data_source.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_remote_data_source.dart';
import 'package:astronomy_picture/data/repositories/search/search_repository_impl.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import '../fetch_apod/fetch_apod_repository_impl_test.mocks.dart';
import 'search_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<SearchRemoteDataSource>(), MockSpec<SearchLocalDataSource>()])
void main() {
  late MockSearchLocalDataSource localDataSource;
  late MockSearchRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late SearchRepository repository;

  setUp(() {
    localDataSource = MockSearchLocalDataSource();
    remoteDataSource = MockSearchRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = SearchRepositoryImpl(
        localDataSource: localDataSource,
        remoteDataSource: remoteDataSource,
        networkInfo: networkInfo);
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

  group('function getApodByDateRange', () {
    test("Should return a list of Apod entity on the Right side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getApodByDateRange(any, any))
          .thenAnswer((_) async => tListApodModel());

      final result =
          await repository.getApodByDateRange('2022-05-05', '2022-05-01');

      result.fold((l) {
        expect(l, 1);
      }, (r) {
        expect(r, tListApod());
      });
    });

    test(
        "Should return an Failure entity throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getApodByDateRange(any, any))
          .thenThrow(ApiFailure());

      final result =
          await repository.getApodByDateRange('2022-05-05', '2022-05-01');

      expect(result, Left<Failure, Apod>(ApiFailure()));
    });

    test("Should return an NoConnection entity on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      final result =
          await repository.getApodByDateRange('2022-05-05', '2022-05-01');

      expect(result, Left<Failure, Apod>(NoConnection()));
    });
  });
}
