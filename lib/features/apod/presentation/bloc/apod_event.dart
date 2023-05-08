part of 'apod_bloc.dart';

abstract class ApodEvent extends Equatable {
  const ApodEvent();

  @override
  List<Object> get props => [];
}

class GetTodayApodEvent extends ApodEvent {}

class GetRandomApodEvent extends ApodEvent {}

class GetApodFromDateEvent extends ApodEvent {
  final DateTime date;

  const GetApodFromDateEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class FetchApodEvent extends ApodEvent {}

class GetByDateRangeApodEvent extends ApodEvent {
  final String query;

  const GetByDateRangeApodEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class IsSaveApodEvent extends ApodEvent {
  final String date;

  const IsSaveApodEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class GetAllSaveApodEvent extends ApodEvent {}

class RemoveSaveApodEvent extends ApodEvent {
  final String date;

  const RemoveSaveApodEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class SaveApodEvent extends ApodEvent {
  final Apod apod;

  const SaveApodEvent({required this.apod});

  @override
  List<Object> get props => [apod];
}
