part of 'bookmark_apod_bloc.dart';

abstract class BookmarkApodState extends Equatable {
  const BookmarkApodState();

  @override
  List<Object> get props => [];
}

class BookmarkApodStateInitial extends BookmarkApodState {}

class LoadingBookmarkApodState extends BookmarkApodState {}

class ErrorBookmarkApodState extends BookmarkApodState {
  final String msg;

  const ErrorBookmarkApodState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class IsSaveBookmarkApodState extends BookmarkApodState {
  final bool wasSave;

  const IsSaveBookmarkApodState({required this.wasSave});

  @override
  List<Object> get props => [wasSave];
}

class SuccessListBookmarkApodState extends BookmarkApodState {
  final List<Apod> list;

  const SuccessListBookmarkApodState({required this.list});

  @override
  List<Object> get props => [list];
}

class LocalAccessSuccessBookmarkApodState extends BookmarkApodState {
  final String msg;

  const LocalAccessSuccessBookmarkApodState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class SuccessHistorySearchBookmarkApodState extends BookmarkApodState {
  final List<String> list;

  const SuccessHistorySearchBookmarkApodState({required this.list});

  @override
  List<Object> get props => [list];
}