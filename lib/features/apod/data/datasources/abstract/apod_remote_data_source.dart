import 'package:astronomy_picture/features/apod/data/models/apod_model.dart';

/// Apod Remote Data Source - Get Resource from Nasa APOD API
abstract class ApodRemoteDataSource {
  /// Receive a [DateTime] and
  /// Return a [ApodModel] date case is a success, otherwise
  /// throw a [Failure]
  Future<ApodModel> getApodFromDate(DateTime date);

  /// Return a [ApodModel] date case is a success, otherwise
  /// throw a [Failure]
  Future<ApodModel> getRandomApod();

  /// Return a [ApodModel] date case is a success, otherwise
  /// throw a [Failure]
  Future<ApodModel> getTodayApod();

  /// Return a [ApodModel] list date case is a success, otherwise
  /// throw a [Failure]
  Future<List<ApodModel>> fetchApod();

  /// Return a [ApodModel] list date case is a success, otherwise
  /// throw a [Failure]
  Future<List<ApodModel>> getApodByDateRange(String startDate, String endDate);
}
