import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveSaveApod extends UseCase<SuccessReturn, String> {
  final ApodLocalRepository repository;

  RemoveSaveApod({required this.repository});

  @override
  Future<Either<Failure, SuccessReturn>> call(String parameter) async {
    return await repository.removeSaveApod(parameter);
  }
}
