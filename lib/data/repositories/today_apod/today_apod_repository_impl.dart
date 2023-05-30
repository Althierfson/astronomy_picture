import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:dartz/dartz.dart';

class TodayApodRepositoryImpl implements TodayApodRepository {
  final TodayApodDataSource todayApodDataSource;
  final NetworkInfo networkInfo;

  TodayApodRepositoryImpl(
      {required this.todayApodDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Apod>> getTodayApod() async {
    if (await networkInfo.isConnected) {
      try {
        final apod = await todayApodDataSource.getTodayApod();
        return Right(apod.toEntity());
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }
}
