import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_local_data_source.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_remote_data_source.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Apod>>> getApodByDateRange(
      String startDate, String endDate) async {
    if (await networkInfo.isConnected) {
      try {
        final apod =
            await remoteDataSource.getApodByDateRange(startDate, endDate);
        return Right(List.from(apod.map((e) => e.toEntity())));
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }

  @override
  Future<Either<Failure, List<String>>> updateSearchHistory(
      List<String> historyList) async {
    return await _callLocalDataSource(
        () => localDataSource.updateSearchHistory(historyList));
  }

  @override
  Future<Either<Failure, List<String>>> fetchSearchHistory() async {
    return await _callLocalDataSource(() => localDataSource.getSearchHistory());
  }

  Future<Either<Failure, A>> _callLocalDataSource<A>(
      Future<A> Function() func) async {
    try {
      return Right(await func());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
