import 'package:astronomy_picture/data/models/apod_model.dart';

abstract class FetchApodDataSource {
  /// Return a [ApodModel] list date case is a success, otherwise
  /// throw a [Failure]
  Future<List<ApodModel>> fetchApod();
}
