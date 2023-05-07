import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:dartz/dartz.dart';

class SaveApod extends UseCase<SuccessReturn, Apod> {
  final ApodLocalRepository repository;

  SaveApod({required this.repository});

  @override
  Future<Either<Failure, SuccessReturn>> call(Apod parameter) async {
    return await repository.saveApod(parameter);
  }
}
