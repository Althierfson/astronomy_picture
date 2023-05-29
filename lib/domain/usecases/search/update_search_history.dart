import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

/// Save and return the updated list
class UpdateSearchHistory extends UseCase<List<String>, List<String>> {
  final SearchRepository repository;

  UpdateSearchHistory({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(List<String> parameter) async {
    return await repository.updateSearchHistory(parameter);
  }
}
