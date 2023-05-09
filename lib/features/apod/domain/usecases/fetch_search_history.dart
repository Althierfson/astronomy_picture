import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:dartz/dartz.dart';

/// Get history list
class FetchSearchHistory extends UseCase<List<String>, NoParameter> {
  final ApodLocalRepository repository;

  FetchSearchHistory({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(NoParameter parameter) async {
    return await repository.fetchSearchHistory();
  }
}
