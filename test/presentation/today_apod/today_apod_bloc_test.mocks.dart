// Mocks generated by Mockito 5.4.0 from annotations
// in astronomy_picture/test/presentation/today_apod/today_apod_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:astronomy_picture/core/failure.dart' as _i5;
import 'package:astronomy_picture/domain/entities/apod.dart' as _i6;
import 'package:astronomy_picture/domain/usecases/core/usecase.dart' as _i7;
import 'package:astronomy_picture/domain/usecases/today_apod/get_today_apod.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
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
class MockGetTodayApod extends _i1.Mock implements _i3.GetTodayApod {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Apod>> call(
          _i7.NoParameter? parameter) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [parameter],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Apod>>.value(
            _FakeEither_0<_i5.Failure, _i6.Apod>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Apod>>.value(
                _FakeEither_0<_i5.Failure, _i6.Apod>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Apod>>);
}
