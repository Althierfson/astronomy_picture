import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/save_apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../teste_values.dart';
import 'save_apod_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApodLocalRepository>()])
void main() {
  late MockApodLocalRepository repository;
  late SaveApod usecase;

  setUp(() {
    repository = MockApodLocalRepository();
    usecase = SaveApod(repository: repository);
  });

  test('Should return a SuccessReturn on  Right side of Either', () async {
    when(repository.saveApod(any))
        .thenAnswer((_) async => Right<Failure, SuccessReturn>(ApodSave()));

    final result = await usecase(tApod());

    expect(result, Right<Failure, SuccessReturn>(ApodSave()));
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.saveApod(any)).thenAnswer(
        (_) async => Left<Failure, SuccessReturn>(SaveDataFailure()));

    final result = await usecase(tApod());

    expect(result, Left<Failure, SuccessReturn>(SaveDataFailure()));
  });
}
