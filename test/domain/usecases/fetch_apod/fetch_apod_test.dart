import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/fetch_apod/fetch_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/fetch_apod/fetch_apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import 'fetch_apod_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodRepository>()])
void main() {
  late MockFetchApodRepository repository;
  late FetchApod usecase;

  setUp(() {
    repository = MockFetchApodRepository();
    usecase = FetchApod(repository: repository);
  });

  test('Should return a list of Apod entity Right side of Either', () async {
    when(repository.fetchApod())
        .thenAnswer((_) async => Right<Failure, List<Apod>>(tListApod()));

    final result = await usecase(NoParameter());

    result.fold((l) {
      expect(l, 1);
    }, (r) {
      expect(r, tListApod());
    });
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.fetchApod())
        .thenAnswer((_) async => Left<Failure, List<Apod>>(NoConnection()));

    final result = await usecase(NoParameter());

    expect(result, Left<Failure, Apod>(NoConnection()));
  });
}
