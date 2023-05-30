part of 'today_apod_bloc.dart';

abstract class TodayApodState extends Equatable {
  const TodayApodState();

  @override
  List<Object> get props => [];
}

class TodayApodInitial extends TodayApodState {}

class LoadingTodayApodState extends TodayApodState {}

class ErrorTodayApodState extends TodayApodState {
  final String msg;

  const ErrorTodayApodState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class SuccessTodayApodState extends TodayApodState {
  final Apod apod;

  const SuccessTodayApodState({required this.apod});

  @override
  List<Object> get props => [apod];
}
