import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/data/datasources/bookmark_apod/bookmark_apod_data_source.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/bookmark_apod/bookmark_apod_repository.dart';
import 'package:dartz/dartz.dart';

class BookmarkApodRepositoryImpl implements BookmarkApodRepository {
  final BookmarkApodDataSource bookmarkApodDataSource;

  BookmarkApodRepositoryImpl({required this.bookmarkApodDataSource});

  @override
  Future<Either<Failure, bool>> apodIsSave(String apodDate) async {
    return _callDataSource(() => bookmarkApodDataSource.apodIsSave(apodDate));
  }

  @override
  Future<Either<Failure, List<Apod>>> getAllApodSave() async {
    try {
      final list = await bookmarkApodDataSource.getAllApodSave();
      return Right(List.from(list.map((e) => e.toEntity())));
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, SuccessReturn>> removeSaveApod(String apodDate) async {
    return _callDataSource(() => bookmarkApodDataSource.removeSaveApod(apodDate));
  }

  @override
  Future<Either<Failure, SuccessReturn>> saveApod(Apod apod) async {
    return await _callDataSource(
        () => bookmarkApodDataSource.saveApod(ApodModel.fromEntity(apod)));
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