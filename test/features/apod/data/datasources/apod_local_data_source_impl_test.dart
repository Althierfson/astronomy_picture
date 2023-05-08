import 'dart:convert';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/features/apod/data/datasources/apod_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixtures.dart';
import '../../../../teste_values.dart';
import 'apod_local_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences sharedPreferences;
  late ApodLocalDataSourceImpl localDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource =
        ApodLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  group("Function saveApod", () {
    test("Should return an ApodSave", () async {
      when(sharedPreferences.setString(any, any)).thenAnswer((_) async => true);

      final result = await localDataSource.saveApod(tApodModel());

      verify(sharedPreferences.setString(
          "APOD_KEY=2004-09-27", jsonEncode(tApodModel().toJson())));

      expect(result, ApodSave());
    });

    test("Should throw a SaveDataFailure when the sharedPreferences failure",
        () async {
      when(sharedPreferences.setString(any, any))
          .thenThrow(Exception("Exception"));

      expect(() => localDataSource.saveApod(tApodModel()),
          throwsA(isA<SaveDataFailure>()));
    });
  });

  group("Function removeSaveApod", () {
    test("Should return an ApodSaveRemoved", () async {
      when(sharedPreferences.remove(any)).thenAnswer((_) async => true);

      final result = await localDataSource.removeSaveApod("2004-09-27");

      verify(sharedPreferences.remove("APOD_KEY=2004-09-27"));

      expect(result, ApodSaveRemoved());
    });

    test("Should throw a RemoveDataFailure when the sharedPreferences failure",
        () async {
      when(sharedPreferences.remove(any)).thenThrow(Exception("Exception"));

      expect(() => localDataSource.removeSaveApod("2004-09-27"),
          throwsA(isA<RemoveDataFailure>()));
    });
  });

  group("Function apodIsSave", () {
    test("Should return a true", () async {
      when(sharedPreferences.containsKey(any)).thenAnswer((_) => true);

      final result = await localDataSource.apodIsSave("2004-09-27");

      verify(sharedPreferences.containsKey("APOD_KEY=2004-09-27"));

      expect(result, true);
    });

    test("Should return a false", () async {
      when(sharedPreferences.containsKey(any)).thenAnswer((_) => false);

      final result = await localDataSource.apodIsSave("2004-09-27");

      verify(sharedPreferences.containsKey("APOD_KEY=2004-09-27"));

      expect(result, false);
    });

    test(
        "Should throw a AccessLocalDataFailure when the sharedPreferences failure",
        () async {
      when(sharedPreferences.containsKey(any))
          .thenThrow(Exception("Exception"));

      expect(() => localDataSource.apodIsSave("2004-09-27"),
          throwsA(isA<AccessLocalDataFailure>()));
    });
  });

  group("Function getAllApodSave", () {
    test("Should return a List of ApodModel", () async {
      when(sharedPreferences.getKeys()).thenReturn({'chave1'});
      when(sharedPreferences.getString(any))
          .thenAnswer((_) => fixture('image.json'));

      final result = await localDataSource.getAllApodSave();

      expect(result, [tApodModel()]);
    });

    test("Should throw a RemoveDataFailure when the sharedPreferences failure",
        () async {
      when(sharedPreferences.getKeys()).thenReturn({'chave1'});
      when(sharedPreferences.getString(any)).thenThrow(Exception("Exception"));

      expect(() => localDataSource.getAllApodSave(),
          throwsA(isA<AccessLocalDataFailure>()));
    });
  });
}
