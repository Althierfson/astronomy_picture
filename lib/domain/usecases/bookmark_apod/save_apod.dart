import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/domain/repositories/bookmark_apod/bookmark_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

class SaveApod extends UseCase<SuccessReturn, Apod> {
  final BookmarkApodRepository repository;

  SaveApod({required this.repository});

  @override
  Future<Either<Failure, SuccessReturn>> call(Apod parameter) async {
    return await repository.saveApod(parameter);
  }
}
