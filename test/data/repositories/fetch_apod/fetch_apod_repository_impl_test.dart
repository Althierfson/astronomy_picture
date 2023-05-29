import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/fetch_apod/fetch_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/repositories/fetch_apod/fetch_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/fetch_apod/fetch_apod_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import 'fetch_apod_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodDataSource>(), MockSpec<NetworkInfo>()])
void main() {
  late MockFetchApodDataSource fetchApodDataSource;
  late MockNetworkInfo networkInfo;
  late FetchApodRepository repository;

  setUp(() {
    fetchApodDataSource = MockFetchApodDataSource();
    networkInfo = MockNetworkInfo();
    repository = FetchApodRepositoryImpl(
        fetchApodDataSource: fetchApodDataSource, networkInfo: networkInfo);
  });

  group('function fetchApod', () {
    test("Should return a list of Apod entity on the Right side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(fetchApodDataSource.fetchApod())
          .thenAnswer((_) async => tListApodModel());

      final result = await repository.fetchApod();

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
      when(fetchApodDataSource.fetchApod()).thenThrow((ApiFailure()));

      final result = await repository.fetchApod();

      expect(result, Left<Failure, Apod>(ApiFailure()));
    });

    test("Should return an NoConnection entity on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.fetchApod();

      verifyNever(fetchApodDataSource.fetchApod());

      expect(result, Left<Failure, Apod>(NoConnection()));
    });
  });
}
