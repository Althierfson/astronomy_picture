// Mocks generated by Mockito 5.4.0 from annotations
// in astronomy_picture/test/features/apod/presentation/apod_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:astronomy_picture/core/failure.dart' as _i6;
import 'package:astronomy_picture/core/util/usecase.dart' as _i8;
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart'
    as _i7;
import 'package:astronomy_picture/features/apod/domain/repositories/apod_repository.dart'
    as _i2;
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_from_date.dart'
    as _i10;
import 'package:astronomy_picture/features/apod/domain/usecases/get_random_apod.dart'
    as _i9;
import 'package:astronomy_picture/features/apod/domain/usecases/get_today_apod.dart'
    as _i4;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeApodRepository_0 extends _i1.SmartFake
    implements _i2.ApodRepository {
  _FakeApodRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTodayApod].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTodayApod extends _i1.Mock implements _i4.GetTodayApod {
  @override
  _i2.ApodRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeApodRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeApodRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ApodRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>> call(
          _i8.NoParameter? parameter) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [parameter],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>.value(
            _FakeEither_1<_i6.Failure, _i7.Apod>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>.value(
                _FakeEither_1<_i6.Failure, _i7.Apod>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>);
}

/// A class which mocks [GetRandomApod].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRandomApod extends _i1.Mock implements _i9.GetRandomApod {
  @override
  _i2.ApodRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeApodRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeApodRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ApodRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>> call(
          _i8.NoParameter? parameter) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [parameter],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>.value(
            _FakeEither_1<_i6.Failure, _i7.Apod>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>.value(
                _FakeEither_1<_i6.Failure, _i7.Apod>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>);
}

/// A class which mocks [GetApodFromDate].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetApodFromDate extends _i1.Mock implements _i10.GetApodFromDate {
  @override
  _i2.ApodRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeApodRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeApodRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ApodRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>> call(DateTime? parameter) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [parameter],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>.value(
            _FakeEither_1<_i6.Failure, _i7.Apod>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>.value(
                _FakeEither_1<_i6.Failure, _i7.Apod>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Apod>>);
}
