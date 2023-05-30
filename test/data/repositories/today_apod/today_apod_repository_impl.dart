import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:astronomy_picture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import '../fetch_apod/fetch_apod_repository_impl_test.mocks.dart';
import 'today_apod_repository_impl.mocks.dart';

@GenerateNiceMocks([MockSpec<TodayApodDataSource>()])
void main() {
  late MockTodayApodDataSource dataSource;
  late MockNetworkInfo networkInfo;
  late TodayApodRepository repository;

  setUp(() {
    dataSource = MockTodayApodDataSource();
    networkInfo = MockNetworkInfo();
    repository = TodayApodRepositoryImpl(
        todayApodDataSource: dataSource, networkInfo: networkInfo);
  });

  group('function getTodayApod', () {
    test("Should return an Apod entity on the Right side of Either", () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(dataSource.getTodayApod()).thenAnswer((_) async => tApodModel());

      final result = await repository.getTodayApod();

      expect(result, Right<Failure, Apod>(tApod()));
    });

    test(
        "Should return an Failure entity throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(dataSource.getTodayApod()).thenThrow(ApiFailure());

      final result = await repository.getTodayApod();

      expect(result, Left<Failure, Apod>(ApiFailure()));
    });

    test("Should return an NoConnection entity on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getTodayApod();

      verifyNever(dataSource.getTodayApod());

      expect(result, Left<Failure, Apod>(NoConnection()));
    });
  });
}
