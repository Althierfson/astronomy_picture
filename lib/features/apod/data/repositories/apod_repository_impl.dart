import 'package:astronomy_picture/core/util/network_info.dart';
import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_remote_data_source.dart';
import 'package:astronomy_picture/features/apod/data/models/apod_model.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_repository.dart';
import 'package:dartz/dartz.dart';

class ApodRepositoryImpl implements ApodRepository {
  ApodRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  ApodRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Apod>> getApodFromDate(DateTime date) async {
    return await callRemoteDataSource(
        () => remoteDataSource.getApodFromDate(date));
  }

  @override
  Future<Either<Failure, Apod>> getRandomApod() async {
    return await callRemoteDataSource(() => remoteDataSource.getRandomApod());
  }

  @override
  Future<Either<Failure, Apod>> getTodayApod() async {
    return await callRemoteDataSource(() => remoteDataSource.getTodayApod());
  }

  Future<Either<Failure, Apod>> callRemoteDataSource(
      Future<ApodModel> Function() func) async {
    if (await networkInfo.isConnected) {
      try {
        final apod = await func();
        return Right(apod.toEntity());
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }
}
