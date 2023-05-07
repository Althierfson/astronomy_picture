import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/apod_is_save.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'save_apod_test.mocks.dart';

void main() {
  late MockApodLocalRepository repository;
  late ApodIsSave usecase;

  setUp(() {
    repository = MockApodLocalRepository();
    usecase = ApodIsSave(repository: repository);
  });

  test('Should return a bool on  Right side of Either', () async {
    when(repository.apodIsSave(any))
        .thenAnswer((_) async => const Right<Failure, bool>(true));

    final result = await usecase("date");

    expect(result, const Right<Failure, bool>(true));
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.apodIsSave(any)).thenAnswer(
        (_) async => Left<Failure, bool>(AccessLocalDataFailure()));

    final result = await usecase("date");

    expect(result, Left<Failure, SuccessReturn>(AccessLocalDataFailure()));
  });
}
