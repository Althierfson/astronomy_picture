import 'dart:convert';
import 'dart:io';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/fetch_apod/fetch_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/fetch_apod/fetch_apod_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixtures.dart';
import '../../../teste_values.dart';
import 'fetch_apod_data_source_imp_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late MockClient client;
  late FetchApodDataSource fetchApodDataSource;

  setUp(() {
    client = MockClient();
    fetchApodDataSource = FetchApodDataSourceImpl(client: client);
  });

  group("Function fetchApod", () {
    test("Should return a list Apod model", () async {
      http.Response tResponseSuccessList =
          http.Response.bytes(utf8.encode(fixture('image_list.json')), 200);
      when(client.get(any)).thenAnswer((_) async => tResponseSuccessList);

      final result = await fetchApodDataSource.fetchApod();

      expect(result, tListApodModel());
    });

    test("Should throw an ApiFailure when API no return 500", () async {
      when(client.get(any)).thenAnswer(
          (_) async => http.Response.bytes(utf8.encode("erro"), 500));

      expect(() => fetchApodDataSource.fetchApod(), throwsA(isA<ApiFailure>()));
    });

    test("Should throw an ApiFailure when happen a exception", () async {
      when(client.get(any)).thenThrow(const SocketException("message"));

      expect(() => fetchApodDataSource.fetchApod(), throwsA(isA<ApiFailure>()));
    });
  });
}
