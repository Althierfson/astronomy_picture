import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  /// Return a list of Apod date on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<Apod>>> getApodByDateRange(
      String startDate, String endDate);

  /// Return an String List on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<String>>> updateSearchHistory(
      List<String> historyList);

  /// Return an String List on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<String>>> fetchSearchHistory();
}
