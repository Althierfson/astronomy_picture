// Mocks generated by Mockito 5.4.0 from annotations
// in astronomy_picture/test/features/apod/data/repositories/apod_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:astronomy_picture/core/util/network_info.dart' as _i5;
import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_remote_data_source.dart'
    as _i3;
import 'package:astronomy_picture/features/apod/data/models/apod_model.dart'
    as _i2;
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

class _FakeApodModel_0 extends _i1.SmartFake implements _i2.ApodModel {
  _FakeApodModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApodRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockApodRemoteDataSource extends _i1.Mock
    implements _i3.ApodRemoteDataSource {
  @override
  _i4.Future<_i2.ApodModel> getApodFromDate(DateTime? date) =>
      (super.noSuchMethod(
        Invocation.method(
          #getApodFromDate,
          [date],
        ),
        returnValue: _i4.Future<_i2.ApodModel>.value(_FakeApodModel_0(
          this,
          Invocation.method(
            #getApodFromDate,
            [date],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.ApodModel>.value(_FakeApodModel_0(
          this,
          Invocation.method(
            #getApodFromDate,
            [date],
          ),
        )),
      ) as _i4.Future<_i2.ApodModel>);
  @override
  _i4.Future<_i2.ApodModel> getRandomApod() => (super.noSuchMethod(
        Invocation.method(
          #getRandomApod,
          [],
        ),
        returnValue: _i4.Future<_i2.ApodModel>.value(_FakeApodModel_0(
          this,
          Invocation.method(
            #getRandomApod,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.ApodModel>.value(_FakeApodModel_0(
          this,
          Invocation.method(
            #getRandomApod,
            [],
          ),
        )),
      ) as _i4.Future<_i2.ApodModel>);
  @override
  _i4.Future<_i2.ApodModel> getTodayApod() => (super.noSuchMethod(
        Invocation.method(
          #getTodayApod,
          [],
        ),
        returnValue: _i4.Future<_i2.ApodModel>.value(_FakeApodModel_0(
          this,
          Invocation.method(
            #getTodayApod,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.ApodModel>.value(_FakeApodModel_0(
          this,
          Invocation.method(
            #getTodayApod,
            [],
          ),
        )),
      ) as _i4.Future<_i2.ApodModel>);
  @override
  _i4.Future<List<_i2.ApodModel>> fetchApod() => (super.noSuchMethod(
        Invocation.method(
          #fetchApod,
          [],
        ),
        returnValue: _i4.Future<List<_i2.ApodModel>>.value(<_i2.ApodModel>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.ApodModel>>.value(<_i2.ApodModel>[]),
      ) as _i4.Future<List<_i2.ApodModel>>);
  @override
  _i4.Future<List<_i2.ApodModel>> getApodByDateRange(
    String? startDate,
    String? endDate,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getApodByDateRange,
          [
            startDate,
            endDate,
          ],
        ),
        returnValue: _i4.Future<List<_i2.ApodModel>>.value(<_i2.ApodModel>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.ApodModel>>.value(<_i2.ApodModel>[]),
      ) as _i4.Future<List<_i2.ApodModel>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i5.NetworkInfo {
  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
