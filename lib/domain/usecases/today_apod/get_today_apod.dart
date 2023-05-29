import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

/// Return a Apod of the day
class GetTodayApod extends UseCase<Apod, NoParameter> {
  final TodayApodRepository repository;

  GetTodayApod({required this.repository});

  @override
  Future<Either<Failure, Apod>> call(NoParameter parameter) async {
    return await repository.getTodayApod();
  }
}
