import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/network_info.dart';
import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_remote_data_source.dart';
import 'package:astronomy_picture/features/apod/data/repositories/apod_repository_impl.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../teste_values.dart';
import 'apod_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApodRemoteDataSource>(), MockSpec<NetworkInfo>()])
void main() {
  MockApodRemoteDataSource remoteDataSource = MockApodRemoteDataSource();
  MockNetworkInfo networkInfo = MockNetworkInfo();
  ApodRepositoryImpl repository = ApodRepositoryImpl(
      remoteDataSource: remoteDataSource, networkInfo: networkInfo);

  setUp(() {
    remoteDataSource = MockApodRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = ApodRepositoryImpl(
        remoteDataSource: remoteDataSource, networkInfo: networkInfo);
  });

  ApiFailure tApiFailure = ApiFailure();
  NoConnection tNoConnection = NoConnection();

  group('function getTodayApod', () {
    test("Should return an Apod entity on the Right side of Either", () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getTodayApod()).thenAnswer((_) async => tApodModel());

      final result = await repository.getTodayApod();

      expect(result, Right<Failure, Apod>(tApod()));
    });

    test(
        "Should return an Failure entity throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getTodayApod()).thenThrow(tApiFailure);

      final result = await repository.getTodayApod();

      expect(result, Left<Failure, Apod>(tApiFailure));
    });

    test("Should return an NoConnection entity on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getTodayApod();

      verifyNever(remoteDataSource.getTodayApod());

      expect(result, Left<Failure, Apod>(tNoConnection));
    });
  });

  group('function getRandonApod', () {
    test("Should return an Apod entity on the Right side of Either", () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getRandomApod()).thenAnswer((_) async => tApodModel());

      final result = await repository.getRandomApod();

      expect(result, Right<Failure, Apod>(tApod()));
    });

    test(
        "Should return an Failure entity throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getRandomApod()).thenThrow(tApiFailure);

      final result = await repository.getRandomApod();

      expect(result, Left<Failure, Apod>(tApiFailure));
    });

    test("Should return an NoConnection entity on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getRandomApod();

      verifyNever(remoteDataSource.getRandomApod());

      expect(result, Left<Failure, Apod>(tNoConnection));
    });
  });

  group('function getApodFromDate', () {
    test("Should return an Apod entity on the Right side of Either", () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getApodFromDate(any)).thenAnswer((_) async => tApodModel());

      final result = await repository.getApodFromDate(tDateTime());

      expect(result, Right<Failure, Apod>(tApod()));
    });

    test(
        "Should return an Failure entity throw by remoteDataDource on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getApodFromDate(any)).thenThrow(tApiFailure);

      final result = await repository.getApodFromDate(tDateTime());

      expect(result, Left<Failure, Apod>(tApiFailure));
    });

    test("Should return an NoConnection entity on the Lefth side of Either",
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getApodFromDate(tDateTime());

      verifyNever(remoteDataSource.getApodFromDate(tDateTime()));

      expect(result, Left<Failure, Apod>(tNoConnection));
    });
  });
}
