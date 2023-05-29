import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/fetch_apod/fetch_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

/// Returns a list of Apod
class FetchApod extends UseCase<List<Apod>, NoParameter> {
  final FetchApodRepository repository;

  FetchApod({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(NoParameter parameter) async {
    return await repository.fetchApod();
  }
}
