import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_repository.dart';
import 'package:dartz/dartz.dart';

/// Returns an APod based on a date
class GetApodFromDate extends UseCase<Apod, DateTime> {
  final ApodRepository repository;

  GetApodFromDate({required this.repository});

  @override
  Future<Either<Failure, Apod>> call(DateTime parameter) async {
    return await repository.getApodFromDate(parameter);
  }
}
