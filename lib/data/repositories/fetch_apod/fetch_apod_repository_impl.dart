import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/fetch_apod/fetch_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/fetch_apod/fetch_apod_repository.dart';
import 'package:dartz/dartz.dart';

class FetchApodRepositoryImpl implements FetchApodRepository {
  FetchApodDataSource fetchApodDataSource;
  NetworkInfo networkInfo;

  FetchApodRepositoryImpl(
      {required this.fetchApodDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Apod>>> fetchApod() async {
    if (await networkInfo.isConnected) {
      try {
        final apod = await fetchApodDataSource.fetchApod();
        return Right(List.from(apod.map((e) => e.toEntity())));
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }
}
