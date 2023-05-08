import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_all_apod_save.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../teste_values.dart';
import 'save_apod_test.mocks.dart';

void main() {
  late MockApodLocalRepository repository;
  late GetAllApodSave usecase;

  setUp(() {
    repository = MockApodLocalRepository();
    usecase = GetAllApodSave(repository: repository);
  });

  test('Should return an Apod list on  Right side of Either', () async {
    when(repository.getAllApodSave())
        .thenAnswer((_) async => Right<Failure, List<Apod>>(tListApod()));

    final result = await usecase(NoParameter());

    result.fold((l) {
      fail("Test Failure");
    }, (r) {
      expect(r, tListApod());
    });
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.getAllApodSave()).thenAnswer(
        (_) async => Left<Failure, List<Apod>>(AccessLocalDataFailure()));

    final result = await usecase(NoParameter());

    expect(result, Left<Failure, List<Apod>>(AccessLocalDataFailure()));
  });
}
