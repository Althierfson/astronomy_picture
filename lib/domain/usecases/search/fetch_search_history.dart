import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

/// Get history list
class FetchSearchHistory extends UseCase<List<String>, NoParameter> {
  final SearchRepository repository;

  FetchSearchHistory({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(NoParameter parameter) async {
    return await repository.fetchSearchHistory();
  }
}
