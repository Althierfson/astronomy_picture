import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/bookmark_apod/bookmark_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

class GetAllApodSave extends UseCase<List<Apod>, NoParameter> {
  final BookmarkApodRepository repository;

  GetAllApodSave({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(NoParameter parameter) async {
    return await repository.getAllApodSave();
  }
}
