import 'dart:convert';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';

import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/core/date_convert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/keys.dart';
import 'bookmark_apod_data_source.dart';

const String apodKey = 'APOD_KEY';

class BookmarkApodDataSourceImpl extends BookmarkApodDataSource {
  final SharedPreferences sharedPreferences;

  BookmarkApodDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> apodIsSave(String apodDate) async {
    try {
      return sharedPreferences.containsKey("$apodKey=$apodDate");
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<List<ApodModel>> getAllApodSave() async {
    try {
      final keys = sharedPreferences.getKeys();
      keys.remove(historySearchKey);

      List<ApodModel> list = [];
      for (var k in keys) {
        final json = sharedPreferences.getString(k);
        if (json != null) {
          list.add(ApodModel.fromJson(jsonDecode(json)));
        }
      }
      return list;
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<SuccessReturn> removeSaveApod(String apodDate) async {
    try {
      sharedPreferences.remove("$apodKey=$apodDate");
      return ApodSaveRemoved();
    } catch (e) {
      throw RemoveDataFailure();
    }
  }

  @override
  Future<SuccessReturn> saveApod(ApodModel apod) async {
    try {
      sharedPreferences.setString(
          "$apodKey=${DateConvert.dateToString(apod.date)}",
          jsonEncode(apod.toJson()));
      return ApodSave();
    } catch (e) {
      throw SaveDataFailure();
    }
  }
}
