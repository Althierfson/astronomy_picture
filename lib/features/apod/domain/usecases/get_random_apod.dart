import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomApod extends UseCase<Apod, NoParameter> {
  final ApodRepository repository;

  GetRandomApod({required this.repository});

  @override
  Future<Either<Failure, Apod>> call(NoParameter parameter) async {
    return await repository.getRandomApod();
  }
}
