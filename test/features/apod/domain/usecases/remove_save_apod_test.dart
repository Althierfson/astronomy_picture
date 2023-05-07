import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/remove_save_apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'save_apod_test.mocks.dart';

void main() {
  late MockApodLocalRepository repository;
  late RemoveSaveApod usecase;

  setUp(() {
    repository = MockApodLocalRepository();
    usecase = RemoveSaveApod(repository: repository);
  });

  test('Should return a SuccessReturn on  Right side of Either', () async {
    when(repository.removeSaveApod(any))
        .thenAnswer((_) async => Right<Failure, SuccessReturn>(ApodSaveRemoved()));

    final result = await usecase("date");

    expect(result, Right<Failure, SuccessReturn>(ApodSaveRemoved()));
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.removeSaveApod(any)).thenAnswer(
        (_) async => Left<Failure, SuccessReturn>(RemoveDataFailure()));

    final result = await usecase("date");

    expect(result, Left<Failure, SuccessReturn>(RemoveDataFailure()));
  });
}
