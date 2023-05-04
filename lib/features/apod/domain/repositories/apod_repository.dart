import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

/// Repository from feature apod 
abstract class ApodRepository {
  /// Return a Apod date on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, Apod>> getTodayApod();

  /// Receive a DateTime and
  /// Return a Apod date on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, Apod>> getApodFromDate(DateTime date);

  /// Return a Apod date on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, Apod>> getRandomApod();

  /// Return a list of Apod date on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<Apod>>> fetchApod();
}
