import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/search/fetch_search_history.dart';
import 'package:astronomy_picture/domain/usecases/search/get_apod_by_date_range.dart';
import 'package:astronomy_picture/domain/usecases/search/update_search_history.dart';
import 'package:astronomy_picture/presentation/bloc/search/search_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../teste_values.dart';
import 'search_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FetchSearchHistory>(),
  MockSpec<UpdateSearchHistory>(),
  MockSpec<GetApodByDateRange>()
])
void main() {
  late MockFetchSearchHistory fetchSearchHistory;
  late MockUpdateSearchHistory updateSearchHistory;
  late MockGetApodByDateRange getApodByDateRange;
  late SearchBloc bloc;

  setUp(() {
    fetchSearchHistory = MockFetchSearchHistory();
    updateSearchHistory = MockUpdateSearchHistory();
    getApodByDateRange = MockGetApodByDateRange();
    bloc = SearchBloc(
        fetchSearchHistory: fetchSearchHistory,
        updateSearchHistory: updateSearchHistory,
        getApodByDateRange: getApodByDateRange);
  });

  group("usecase - fetchSearchHistory", () {
    test("Should emit LoadingApodState and SuccessHistorySearchListApodState",
        () {
      when(fetchSearchHistory(any))
          .thenAnswer((_) async => Right(tHistoryList()));

      bloc.input.add(GetHistorySearchEvent());

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            SuccessHistorySearchState(list: tHistoryList())
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(fetchSearchHistory(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      bloc.input.add(GetHistorySearchEvent());

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            ErrorSearchState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("usecase - updateSearchHistory", () {
    test("Should emit LoadingApodState and SuccessHistorySearchListApodState",
        () {
      when(updateSearchHistory(any))
          .thenAnswer((_) async => Right(tHistoryList()));

      bloc.input.add(UpdateHistorySearchEvent(list: tHistoryList()));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            SuccessHistorySearchState(list: tHistoryList())
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(updateSearchHistory(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      bloc.input.add(UpdateHistorySearchEvent(list: tHistoryList()));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            ErrorSearchState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("usecase - GetByDateRangeApodEvent", () {
    test("Should emit LoadingApodState and SuccessListApodState", () {
      when(getApodByDateRange(any)).thenAnswer((_) async => Right(tListApod()));

      bloc.input.add(const GetByDateRangeSearchEvent(query: "Query"));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            SuccessListSearchState(list: tListApod())
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getApodByDateRange(any)).thenAnswer((_) async => Left(ApiFailure()));

      bloc.input.add(const GetByDateRangeSearchEvent(query: "Query"));

      expect(
          bloc.stream,
          emitsInOrder(
              [LoadingSearchState(), ErrorSearchState(msg: ApiFailure().msg)]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      when(getApodByDateRange(any))
          .thenAnswer((_) async => Left(NoConnection()));

      bloc.input.add(const GetByDateRangeSearchEvent(query: "Query"));

      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            ErrorSearchState(msg: NoConnection().msg)
          ]));
    });
  });
}
