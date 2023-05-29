part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class LoadingSearchState extends SearchState {}

class ErrorSearchState extends SearchState {
  final String msg;

  const ErrorSearchState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class SuccessHistorySearchState extends SearchState {
  final List<String> list;

  const SuccessHistorySearchState({required this.list});

  @override
  List<Object> get props => [list];
}

class SuccessListSearchState extends SearchState {
  final List<Apod> list;

  const SuccessListSearchState({required this.list});

  @override
  List<Object> get props => [list];
}
