import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/domain/repositories/bookmark_apod/bookmark_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class RemoveSaveApod extends UseCase<SuccessReturn, String> {
  final BookmarkApodRepository repository;

  RemoveSaveApod({required this.repository});

  @override
  Future<Either<Failure, SuccessReturn>> call(String parameter) async {
    return await repository.removeSaveApod(parameter);
  }
}
