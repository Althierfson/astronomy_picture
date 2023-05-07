import 'dart:convert';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_remote_data_source.dart';
import 'package:astronomy_picture/features/apod/data/models/apod_model.dart';
import 'package:http/http.dart' as http;

// Go to environment.dart to see how to set the environment
import 'package:astronomy_picture/environment.dart';

class ApodRemoteDataSourceImpl implements ApodRemoteDataSource {
  final http.Client client;

  ApodRemoteDataSourceImpl({required this.client});

  @override
  Future<ApodModel> getApodFromDate(DateTime date) async {
    try {
      return await _callClientOneApod(
          () => _makeQuery(QueryType.byDate, date: date));
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<ApodModel> getRandomApod() async {
    try {
      return (await _callClientManyApod(() => _makeQuery(QueryType.random)))[0];
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<ApodModel> getTodayApod() async {
    try {
      return await _callClientOneApod(() => _makeQuery(QueryType.standard));
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<List<ApodModel>> fetchApod() async {
    try {
      return await _callClientManyApod(() => _makeQuery(QueryType.fetch));
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<List<ApodModel>> getApodByDateRange(
      String startDate, String endDate) async {
    try {
      return await _callClientManyApod(() => _makeQuery(QueryType.byDateRange,
          endDate: endDate, startDate: startDate));
    } on Failure {
      rethrow;
    }
  }

  Uri _getUrl() {
    // https://api.nasa.gov/planetary/apod
    return Uri(scheme: 'https', host: 'api.nasa.gov', path: 'planetary/apod');
  }

  Map<String, String> _makeQuery(QueryType queryType,
      {DateTime? date, String? startDate, String? endDate}) {
    Map<String, String> query = {'api_key': Environment.apidKey, 'thumbs': 'true'};
    switch (queryType) {
      case QueryType.standard:
        return query;
      case QueryType.random:
        query['count'] = '1';
        return query;
      case QueryType.byDate:
        if (date != null) {
          query['date'] = '${date.year}-${date.month}-${date.day}';
          return query;
        } else {
          return query;
        }
      case QueryType.fetch:
        query['count'] = '20';
        return query;
      case QueryType.byDateRange:
        query['start_date'] = startDate ?? "";
        query['end_date'] = endDate ?? "";
        return query;
      default:
        return query;
    }
  }

  Future<ApodModel> _callClientOneApod(Function func) async {
    http.Response response;
    try {
      response = await client.get(_getUrl().replace(queryParameters: func()));
    } catch (e) {
      throw ApiFailure();
    }

    if (response.statusCode == 200) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return ApodModel.fromJson(json);
    } else {
      throw ApiFailure();
    }
  }

  Future<List<ApodModel>> _callClientManyApod(Function func) async {
    http.Response response;
    try {
      response = await client.get(_getUrl().replace(queryParameters: func()));
    } catch (e) {
      throw ApiFailure();
    }

    if (response.statusCode == 200) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return List.from(json.map((e) => ApodModel.fromJson(e)));
    } else {
      throw ApiFailure();
    }
  }
}

enum QueryType {
  standard,
  random,
  fetch,
  byDateRange,
  byDate;
}
