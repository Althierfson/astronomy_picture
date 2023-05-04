import 'dart:convert';
import 'dart:io';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/data/datasources/apod_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixtures.dart';
import '../../../../teste_values.dart';
import 'apod_remote_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late MockClient client;
  late ApodRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = ApodRemoteDataSourceImpl(client: client);
  });

  http.Response tResponseSuccess =
      http.Response.bytes(utf8.encode(fixture('image.json')), 200);
  http.Response tResponseFailure =
      http.Response.bytes(utf8.encode("failure"), 500);

  group("Function getTodayApod", () {
    test("Should return an Apod model", () async {
      when(client.get(any)).thenAnswer((_) async => tResponseSuccess);

      final result = await remoteDataSource.getTodayApod();

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true')));

      expect(result, tApodModel());
    });

    test("Should throw an ApiFailure when API no return 200", () async {
      when(client.get(any)).thenAnswer((_) async => tResponseFailure);

      expect(() => remoteDataSource.getTodayApod(), throwsA(isA<ApiFailure>()));

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true')));
    });

    test("Should throw an ApiFailure when happen a exception", () async {
      when(client.get(any)).thenThrow(const SocketException("message"));

      expect(() => remoteDataSource.getTodayApod(), throwsA(isA<ApiFailure>()));

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true')));
    });
  });

  group("Function getRandomApod", () {
    test("Should return an Apod model", () async {
      http.Response tResponseSuccessList =  http.Response.bytes(utf8.encode('[${fixture('image.json')}]'), 200);
      when(client.get(any)).thenAnswer((_) async => tResponseSuccessList);

      final result = await remoteDataSource.getRandomApod();

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&count=1')));

      expect(result, tApodModel());
    });

    test("Should throw an ApiFailure when API no return 200", () async {
      when(client.get(any)).thenAnswer((_) async => tResponseFailure);

      expect(
          () => remoteDataSource.getRandomApod(), throwsA(isA<ApiFailure>()));

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&count=1')));
    });

    test("Should throw an ApiFailure when happen a exception", () async {
      when(client.get(any)).thenThrow(const SocketException("message"));

      expect(
          () => remoteDataSource.getRandomApod(), throwsA(isA<ApiFailure>()));

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&count=1')));
    });
  });

  group("Function getApodFromDate", () {
    test("Should return an Apod model", () async {
      when(client.get(any)).thenAnswer((_) async => tResponseSuccess);

      final result = await remoteDataSource.getApodFromDate(tDateTime());

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&date=2023-3-22')));

      expect(result, tApodModel());
    });

    test("Should throw an ApiFailure when API no return 200", () async {
      when(client.get(any)).thenAnswer((_) async => tResponseFailure);

      expect(() => remoteDataSource.getApodFromDate(tDateTime()),
          throwsA(isA<ApiFailure>()));

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&date=2023-3-22')));
    });

    test("Should throw an ApiFailure when happen a exception", () async {
      when(client.get(any)).thenThrow(const SocketException("message"));

      expect(() => remoteDataSource.getApodFromDate(tDateTime()),
          throwsA(isA<ApiFailure>()));

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&date=2023-3-22')));
    });
  });

  group("Function fetchApod", () {
    test("Should return a list Apod model", () async {
      http.Response tResponseSuccessList =  http.Response.bytes(utf8.encode(fixture('image_list.json')), 200);
      when(client.get(any)).thenAnswer((_) async => tResponseSuccessList);

      final result = await remoteDataSource.fetchApod();

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&count=20')));

      expect(result, tListApodModel());
    });

    test("Should throw an ApiFailure when API no return 200", () async {
      when(client.get(any)).thenAnswer((_) async => tResponseFailure);

      expect(
          () => remoteDataSource.fetchApod(), throwsA(isA<ApiFailure>()));

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&count=20')));
    });

    test("Should throw an ApiFailure when happen a exception", () async {
      when(client.get(any)).thenThrow(const SocketException("message"));

      expect(
          () => remoteDataSource.fetchApod(), throwsA(isA<ApiFailure>()));

      verify(client.get(Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=em690XssAjFmYIwEKVfMAvfkQecFSQpPfwetfvua&thumbs=true&count=20')));
    });
  });
}
