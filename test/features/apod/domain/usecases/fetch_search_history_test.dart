import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/util/usecase.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/fetch_search_history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../teste_values.dart';
import 'save_apod_test.mocks.dart';

void main() {
  late MockApodLocalRepository repository;
  late FetchSearchHistory usecase;

  setUp(() {
    repository = MockApodLocalRepository();
    usecase = FetchSearchHistory(repository: repository);
  });

  test('Should return a List of String on  Right side of Either', () async {
    when(repository.fetchSearchHistory())
        .thenAnswer((_) async => Right<Failure, List<String>>(tHistoryList()));

    final result = await usecase(NoParameter());

    result.fold((l) => fail("Test failed"), (r) => expect(r, tHistoryList()));
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.fetchSearchHistory()).thenAnswer(
        (_) async => Left<Failure, List<String>>(AccessLocalDataFailure()));

    final result = await usecase(NoParameter());

    expect(result, Left<Failure, List<String>>(AccessLocalDataFailure()));
  });
}
