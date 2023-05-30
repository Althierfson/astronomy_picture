import 'dart:convert';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/fetch_apod/fetch_apod_data_source.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:astronomy_picture/environment.dart';
import 'package:http/http.dart' as http;

class FetchApodDataSourceImpl implements FetchApodDataSource {
  final http.Client client;

  FetchApodDataSourceImpl({required this.client});

  @override
  Future<List<ApodModel>> fetchApod() async {
    http.Response response;
    try {
      response = await client.get(Uri.parse("${Environment.urlBase}&count=20"));
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
