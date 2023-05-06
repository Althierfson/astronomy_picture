import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/date_convert.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_repository.dart';
import 'package:dartz/dartz.dart';

class GetApodByDateRange extends UseCase<List<Apod>, String> {
  final ApodRepository repository;

  GetApodByDateRange({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(String parameter) async {
    final query =
        DateConvert.toApodStandard(parameter).fold((l) => l, (r) => r);

    if (query is Map) {
      if (query['end'] == null) {
        return await repository.getApodByDateRange(
            query['start'], query['start']);
      } else {
        return await repository.getApodByDateRange(
            query['start'], query['end']);
      }
    } else {
      return Left(query as Failure);
    }
  }
}
