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
