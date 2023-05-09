import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/update_search_history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../teste_values.dart';
import 'save_apod_test.mocks.dart';

void main() {
  late MockApodLocalRepository repository;
  late UpdateSearchHistory usecase;

  setUp(() {
    repository = MockApodLocalRepository();
    usecase = UpdateSearchHistory(repository: repository);
  });

  test('Should return a List of String on  Right side of Either', () async {
    when(repository.updateSearchHistory(any))
        .thenAnswer((_) async => Right<Failure, List<String>>(tHistoryList()));

    final result = await usecase(tHistoryList());

    result.fold(
      (l) => fail("Test failed"),
      (r) => expect(r, tHistoryList())
    );
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.updateSearchHistory(any)).thenAnswer(
        (_) async => Left<Failure, List<String>>(AccessLocalDataFailure()));

    final result = await usecase(tHistoryList());

    expect(result, Left<Failure, List<String>>(AccessLocalDataFailure()));
  });
}
