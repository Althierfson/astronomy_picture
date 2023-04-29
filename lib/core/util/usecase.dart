import 'package:astronomy_picture/core/failure.dart';
import 'package:dartz/dartz.dart';

/// Default useCase
/// R is the return of function call
/// P is the parameter of function call
abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P parameter);
}

class NoParameter {}