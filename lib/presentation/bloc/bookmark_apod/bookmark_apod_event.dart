part of 'bookmark_apod_bloc.dart';

abstract class BookmarkApodEvent extends Equatable {
  const BookmarkApodEvent();

  @override
  List<Object> get props => [];
}

class IsSaveBookmarkApodEvent extends BookmarkApodEvent {
  final String date;

  const IsSaveBookmarkApodEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class GetAllSaveBookmarkApodEvent extends BookmarkApodEvent {}

class RemoveSaveBookmarkApodEvent extends BookmarkApodEvent {
  final String date;

  const RemoveSaveBookmarkApodEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class SaveBookmarkApodEvent extends BookmarkApodEvent {
  final Apod apod;

  const SaveBookmarkApodEvent({required this.apod});

  @override
  List<Object> get props => [apod];
}
