import 'dart:convert';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_remote_data_source.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:astronomy_picture/environment.dart';
import 'package:http/http.dart' as http;

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final http.Client client;

  SearchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ApodModel>> getApodByDateRange(
      String startDate, String endDate) async {
    http.Response response;

    try {
      response = await client.get(Uri.parse(
          "${Environment.urlBase}&start_date=$startDate&end_date=$endDate"));
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
