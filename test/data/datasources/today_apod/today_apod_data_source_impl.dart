import 'dart:convert';
import 'dart:io';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixtures.dart';
import '../../../teste_values.dart';
import '../fetch_apod/fetch_apod_data_source_imp_test.mocks.dart';

void main() {
  late MockClient client;
  late TodayApodDataSource dataSource;

  setUp(() {
    client = MockClient();
    dataSource = TodayApodDataSourceImpl(client: client);
  });

  group("Function getTodayApod", () {
    test("Should return an Apod model", () async {
      when(client.get(any)).thenAnswer((_) async =>
          http.Response.bytes(utf8.encode(fixture('image.json')), 200));

      final result = await dataSource.getTodayApod();

      expect(result, tApodModel());
    });

    test("Should throw an ApiFailure when API no return 500", () async {
      when(client.get(any)).thenAnswer((_) async =>
          http.Response.bytes(utf8.encode(fixture('image.json')), 500));

      expect(() => dataSource.getTodayApod(), throwsA(isA<ApiFailure>()));
    });

    test("Should throw an ApiFailure when happen a exception", () async {
      when(client.get(any)).thenThrow(const SocketException("message"));

      expect(() => dataSource.getTodayApod(), throwsA(isA<ApiFailure>()));
    });
  });
}
