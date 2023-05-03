import 'dart:convert';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_remote_data_source.dart';
import 'package:astronomy_picture/features/apod/data/models/apod_model.dart';
import 'package:http/http.dart' as http;

/// Environment file with NASA API key
/// You have to create the file in the lib directory
/// You also need to create a String constant with your API key
/// See this link https://api.nasa.gov/ how to get your key
/// 
/// Example of the constant you have to create
/// 
/// const String apiKey = "your_key";
import 'package:astronomy_picture/environment.dart';

class ApodRemoteDataSourceImpl implements ApodRemoteDataSource {
  final http.Client client;

  ApodRemoteDataSourceImpl({required this.client});

  @override
  Future<ApodModel> getApodFromDate(DateTime date) async {
    http.Response response;
    try {
      response = await client.get(_getUrl().replace(
          queryParameters: _makeQuery(QueryType.byDate, date: date)));
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

  @override
  Future<ApodModel> getRandomApod() async {
    http.Response response;
    try {
      response = await client
          .get(_getUrl().replace(queryParameters: _makeQuery(QueryType.random)));
    } catch (e) {
      throw ApiFailure();
    }

    if (response.statusCode == 200) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return ApodModel.fromJson(json[0]);
    } else {
      throw ApiFailure();
    }
  }

  @override
  Future<ApodModel> getTodayApod() async {
    http.Response response;
    try {
      response = await client.get(
          _getUrl().replace(queryParameters: _makeQuery(QueryType.standard)));
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

  Map<String, String> _makeQuery(QueryType queryType, {DateTime? date}) {
    Map<String, String> query = {'api_key': apiKey, 'thumbs': 'true'};
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
      default:
        return query;
    }
  }

  Uri _getUrl() {
    // https://api.nasa.gov/planetary/apod
    return Uri(scheme: 'https', host: 'api.nasa.gov', path: 'planetary/apod');
  }
}

enum QueryType {
  standard,
  random,
  byDate;
}
