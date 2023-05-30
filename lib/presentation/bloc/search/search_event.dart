part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetByDateRangeSearchEvent extends SearchEvent {
  final String query;

  const GetByDateRangeSearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class GetHistorySearchEvent extends SearchEvent {}

class UpdateHistorySearchEvent extends SearchEvent {
  final List<String> list;

  const UpdateHistorySearchEvent({required this.list});

  @override
  List<Object> get props => [list];
}
