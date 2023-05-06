import 'package:astronomy_picture/core/failure.dart';
import 'package:dartz/dartz.dart';

/// Convert DateTime to APOD standard
class DateConvert {
  static String dateToString(DateTime date) {
    return date.toString().substring(0, 10);
  }

  /// When get a query String try convert then to a APOD standard
  /// APOD standard [YYYY-MM-DD]
  static Either<Failure, Map<String, dynamic>> toApodStandard(String query) {
    if (query.length == 21) {
      final list = query.split('/');
      if (list.length == 2) {
        try {
          DateTime.tryParse(list[0]);
          DateTime.tryParse(list[1]);
          return Right({'start': list[0], 'end': list[1]});
        } catch (e) {
          return Left(ConvertFailure());
        }
      } else {
        return Left(ConvertFailure());
      }
    } else if (query.length == 10) {
      try {
        DateTime.tryParse(query);
        return Right({'start': query, 'end': null});
      } catch (e) {
        return Left(ConvertFailure());
      }
    } else {
      return Left(ConvertFailure());
    }
  }
}
