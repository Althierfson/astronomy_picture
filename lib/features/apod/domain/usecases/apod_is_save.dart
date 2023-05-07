import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:dartz/dartz.dart';

class ApodIsSave extends UseCase<bool, String> {
  final ApodLocalRepository repository;

  ApodIsSave({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String parameter) async {
    return await repository.apodIsSave(parameter);
  }
}
