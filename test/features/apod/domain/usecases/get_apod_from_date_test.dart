import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_from_date.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../teste_values.dart';
import 'get_today_apod_test.mocks.dart';

void main() {
  MockApodRepository repository = MockApodRepository();
  GetApodFromDate usecase = GetApodFromDate(repository: repository);

  setUp(() {
    repository = MockApodRepository();
    usecase = GetApodFromDate(repository: repository);
  });

  test('Should return an Apod entity Right side of Either', () async {
    when(repository.getApodFromDate(any))
        .thenAnswer((_) async => Right<Failure, Apod>(tApod()));

    final result = await usecase(tDateTime());

    expect(result, Right<Failure, Apod>(tApod()));
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.getApodFromDate(any))
        .thenAnswer((_) async => Left<Failure, Apod>(NoConnection()));

    final result = await usecase(tDateTime());

    expect(result, Left<Failure, Apod>(NoConnection()));
  });
}
