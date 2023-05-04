import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_repository.dart';
import 'package:dartz/dartz.dart';

/// Returns a list of Apod
class FetchApod extends UseCase<List<Apod>, NoParameter> {
  final ApodRepository repository;

  FetchApod({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(NoParameter parameter) async {
    return await repository.fetchApod();
  }
}
