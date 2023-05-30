import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/keys.dart';

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final SharedPreferences sharedPreferences;

  SearchLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<String>> getSearchHistory() async {
    try {
      return sharedPreferences.getStringList(historySearchKey) ?? [];
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<List<String>> updateSearchHistory(List<String> history) async {
    try {
      await sharedPreferences.setStringList(historySearchKey, history);
      return getSearchHistory();
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }
}
