import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllApodSave extends UseCase<List<Apod>, NoParameter> {
  final ApodLocalRepository repository;

  GetAllApodSave({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(NoParameter parameter) async {
    return await repository.getAllApodSave();
  }
}
