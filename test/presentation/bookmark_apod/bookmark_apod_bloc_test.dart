import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/apod_is_save.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/get_all_apod_save.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/remove_save_apod.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/save_apod.dart';
import 'package:astronomy_picture/presentation/bloc/bookmark_apod/bookmark_apod_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../teste_values.dart';
import 'bookmark_apod_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ApodIsSave>(),
  MockSpec<GetAllApodSave>(),
  MockSpec<RemoveSaveApod>(),
  MockSpec<SaveApod>()
])
void main() {
  late MockApodIsSave apodIsSave;
  late MockGetAllApodSave getAllApodSave;
  late MockRemoveSaveApod removeSaveApod;
  late MockSaveApod saveApod;
  late BookmarkApodBloc bloc;

  setUp(() {
    apodIsSave = MockApodIsSave();
    getAllApodSave = MockGetAllApodSave();
    removeSaveApod = MockRemoveSaveApod();
    saveApod = MockSaveApod();
    bloc = BookmarkApodBloc(
        apodIsSave: apodIsSave,
        getAllApodSave: getAllApodSave,
        removeSaveApod: removeSaveApod,
        saveApod: saveApod);
  });

  group("usecase - ApodIsSave", () {
    test("Should emit LoadingApodState and IsSaveApodState", () {
      when(apodIsSave(any)).thenAnswer((_) async => const Right(true));

      bloc.input.add(const IsSaveBookmarkApodEvent(date: "date"));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingBookmarkApodState(),
            const IsSaveBookmarkApodState(wasSave: true)
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(apodIsSave(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      bloc.input.add(const IsSaveBookmarkApodEvent(date: "date"));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingBookmarkApodState(),
            ErrorBookmarkApodState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("usecase - getAllApodSave", () {
    test("Should emit LoadingApodState and SuccessListApodState", () {
      when(getAllApodSave(any)).thenAnswer((_) async => Right(tListApod()));

      bloc.input.add(GetAllSaveBookmarkApodEvent());

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingBookmarkApodState(),
            SuccessListBookmarkApodState(list: tListApod())
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getAllApodSave(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      bloc.input.add(GetAllSaveBookmarkApodEvent());

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingBookmarkApodState(),
            ErrorBookmarkApodState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("usecase - removeSaveApod", () {
    test("Should emit LoadingApodState and RemoveSaveApodEvent", () {
      when(removeSaveApod(any))
          .thenAnswer((_) async => Right(ApodSaveRemoved()));

      bloc.input.add(const RemoveSaveBookmarkApodEvent(date: "date"));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingBookmarkApodState(),
            LocalAccessSuccessBookmarkApodState(msg: ApodSaveRemoved().msg)
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(removeSaveApod(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      bloc.input.add(const RemoveSaveBookmarkApodEvent(date: "date"));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingBookmarkApodState(),
            ErrorBookmarkApodState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("usecase - saveApod", () {
    test("Should emit LoadingApodState and LocalAccessSuccessApodState", () {
      when(saveApod(any)).thenAnswer((_) async => Right(ApodSave()));

      bloc.input.add(SaveBookmarkApodEvent(apod: tApod()));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingBookmarkApodState(),
            LocalAccessSuccessBookmarkApodState(msg: ApodSave().msg)
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(saveApod(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      bloc.input.add(SaveBookmarkApodEvent(apod: tApod()));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingBookmarkApodState(),
            ErrorBookmarkApodState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });
}
