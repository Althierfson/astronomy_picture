import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:dartz/dartz.dart';

/// Save and return the updated list
class UpdateSearchHistory extends UseCase<List<String>, List<String>> {
  final ApodLocalRepository repository;

  UpdateSearchHistory({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(List<String> parameter) async {
    return await repository.updateSearchHistory(parameter);
  }
}
