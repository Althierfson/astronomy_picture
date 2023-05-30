import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/core/keys.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_local_data_source.dart';
import 'package:astronomy_picture/data/datasources/search/search_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../teste_values.dart';
import '../bookmark_apod/bookmark_apod_data_source_test.mocks.dart';

void main() {
  late MockSharedPreferences sharedPreferences;
  late SearchLocalDataSource localDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource =
        SearchLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  group("Function getSearchHistory", () {
    test("Should return a List of String", () async {
      when(sharedPreferences.getStringList(any))
          .thenAnswer((_) => tHistoryList());

      final result = await localDataSource.getSearchHistory();

      expect(result, tHistoryList());
    });

    test(
        "Should throw a AccessLocalDataFailure when the sharedPreferences failure",
        () async {
      when(sharedPreferences.getStringList(any))
          .thenThrow(Exception("Exception"));

      expect(() => localDataSource.getSearchHistory(),
          throwsA(isA<AccessLocalDataFailure>()));
    });
  });

  group("Function updateSearchHistory", () {
    test("Should return a List of String", () async {
      when(sharedPreferences.getStringList(any))
          .thenAnswer((_) => tHistoryList());
      when(sharedPreferences.setStringList(any, any))
          .thenAnswer((_) async => true);

      final result = await localDataSource.updateSearchHistory(tHistoryList());

      verify(sharedPreferences.setStringList(historySearchKey, tHistoryList()));

      expect(result, tHistoryList());
    });

    test(
        "Should throw a AccessLocalDataFailure when the sharedPreferences failure",
        () async {
      when(sharedPreferences.getStringList(any))
          .thenAnswer((_) => tHistoryList());
      when(sharedPreferences.setStringList(any, any))
          .thenThrow(Exception("Exception"));

      expect(() => localDataSource.updateSearchHistory(tHistoryList()),
          throwsA(isA<AccessLocalDataFailure>()));
    });
  });
}
