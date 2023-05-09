import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_local_data_source.dart';
import 'package:astronomy_picture/features/apod/data/models/apod_model.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:dartz/dartz.dart';

class ApodLocalRepositoryImpl implements ApodLocalRepository {
  final ApodLocalDataSource localDataSource;

  ApodLocalRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> apodIsSave(String apodDate) async {
    return _callDataSource(() => localDataSource.apodIsSave(apodDate));
  }

  @override
  Future<Either<Failure, List<Apod>>> getAllApodSave() async {
    try {
      final list = await localDataSource.getAllApodSave();
      return Right(List.from(list.map((e) => e.toEntity())));
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, SuccessReturn>> removeSaveApod(String apodDate) async {
    return _callDataSource(() => localDataSource.removeSaveApod(apodDate));
  }

  @override
  Future<Either<Failure, SuccessReturn>> saveApod(Apod apod) async {
    return await _callDataSource(
        () => localDataSource.saveApod(ApodModel.fromEntity(apod)));
  }

  @override
  Future<Either<Failure, List<String>>> updateSearchHistory(
      List<String> historyList) async {
    return await _callDataSource(
        () => localDataSource.updateSearchHistory(historyList));
  }

  @override
  Future<Either<Failure, List<String>>> fetchSearchHistory() async {
    return await _callDataSource(() => localDataSource.getSearchHistory());
  }

  Future<Either<Failure, A>> _callDataSource<A>(
      Future<A> Function() func) async {
    try {
      return Right(await func());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
