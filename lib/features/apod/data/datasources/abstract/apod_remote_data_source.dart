import 'package:astronomy_picture/features/apod/data/models/apod_model.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';

/// Apod Remote Data Source - Get Resource from Nasa APOD API
abstract class ApodRemoteDataSource {
  /// Receive a [DateTime] and
  /// Return a [Apod] date case is a success, otherwise
  /// throw a [Failure]
  Future<ApodModel> getApodFromDate(DateTime date);

  /// Return a [Apod] date case is a success, otherwise
  /// throw a [Failure]
  Future<ApodModel> getRandomApod();

  /// Return a [Apod] date case is a success, otherwise
  /// throw a [Failure]
  Future<ApodModel> getTodayApod();
}
