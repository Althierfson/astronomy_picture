import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

abstract class ApodLocalRepository {
  /// Return a SuccessReturn on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, SuccessReturn>> saveApod(Apod apod);

  /// Return a SuccessReturn on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, SuccessReturn>> removeSaveApod(String apodDate);

  /// Return a true on Right side of Either case the APOD is save or
  /// false case is no save, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, bool>> apodIsSave(String apodDate);

  /// Return an Apod List on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<Apod>>> getAllApodSave();

  /// Return an String List on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<String>>> updateSearchHistory(
      List<String> historyList);

  /// Return an String List on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<String>>> fetchSearchHistory();
}
