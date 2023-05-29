import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/get_today_apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import 'get_today_apod_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodayApodRepository>()])
void main() {
  late MockTodayApodRepository repository;
  late GetTodayApod usecase;

  setUp(() {
    repository = MockTodayApodRepository();
    usecase = GetTodayApod(repository: repository);
  });

  test('Should return an Apod entity Right side of Either', () async {
    when(repository.getTodayApod())
        .thenAnswer((_) async => Right<Failure, Apod>(tApod()));

    final result = await usecase(NoParameter());

    expect(result, Right<Failure, Apod>(tApod()));
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.getTodayApod())
        .thenAnswer((_) async => Left<Failure, Apod>(NoConnection()));

    final result = await usecase(NoParameter());

    expect(result, Left<Failure, Apod>(NoConnection()));
  });
}
