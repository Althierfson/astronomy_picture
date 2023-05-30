import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:astronomy_picture/core/date_convert.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

class GetApodByDateRange extends UseCase<List<Apod>, String> {
  final SearchRepository repository;

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
