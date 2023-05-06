import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_by_date_range.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../teste_values.dart';
import 'get_today_apod_test.mocks.dart';

void main() {
  late MockApodRepository repository;
  late GetApodByDateRange usecase;

  setUp(() {
    repository = MockApodRepository();
    usecase = GetApodByDateRange(repository: repository);
  });

  test('Should return a list of Apod entity Right side of Either', () async {
    when(repository.getApodByDateRange(any, any))
        .thenAnswer((_) async => Right<Failure, List<Apod>>(tListApod()));

    final result = await usecase("2022-05-05/2022-05-01");

    result.fold((l) {
      expect(l, 1);
    }, (r) {
      expect(r, tListApod());
    });
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.getApodByDateRange(any, any))
        .thenAnswer((_) async => Left<Failure, List<Apod>>(NoConnection()));

    final result = await usecase("2022-05-05/2022-05-01");

    expect(result, Left<Failure, Apod>(NoConnection()));
  });

  test('Should return an Failure on Left side of Either for incorrect input',
      () async {
    final result =
        await usecase("2022-5-05/2022-05-1");

    expect(result, Left<Failure, Apod>(ConvertFailure()));
  });
}
