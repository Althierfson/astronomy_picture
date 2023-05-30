part of 'today_apod_bloc.dart';

abstract class TodayApodEvent extends Equatable {
  const TodayApodEvent();

  @override
  List<Object> get props => [];
}

class GetTodayApodEvent extends TodayApodEvent {}