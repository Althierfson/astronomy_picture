import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';

abstract class BookmarkApodDataSource {
  /// Return a [SuccessReturn] case is a success, otherwise
  /// throw a [Failure]
  Future<SuccessReturn> saveApod(ApodModel apod);

  /// Return a [SuccessReturn] case is a success, otherwise
  /// throw a [Failure]
  Future<SuccessReturn> removeSaveApod(String apodDate);

  /// Return a [Bool] case is a success,
  /// true to say the apod is save false to not save apod,
  /// otherwise throw a [Failure]
  Future<bool> apodIsSave(String apodDate);

  /// Return a list [ApodModel] case is a success, otherwise
  /// throw a [Failure]
  Future<List<ApodModel>> getAllApodSave();
}
