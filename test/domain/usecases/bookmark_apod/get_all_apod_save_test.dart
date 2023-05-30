import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/get_all_apod_save.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import 'save_apod_test.mocks.dart';

void main() {
  late MockBookmarkApodRepository repository;
  late GetAllApodSave usecase;

  setUp(() {
    repository = MockBookmarkApodRepository();
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
