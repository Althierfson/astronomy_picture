part of 'apod_bloc.dart';

abstract class ApodState extends Equatable {
  const ApodState();

  @override
  List<Object> get props => [];
}

class InitialApodState extends ApodState {}

class LoadingApodState extends ApodState {}

class SuccessApodState extends ApodState {
  final Apod apod;

  const SuccessApodState({required this.apod});

  @override
  List<Object> get props => [apod];
}

class ErrorApodState extends ApodState {
  final String msg;

  const ErrorApodState({required this.msg});

  @override
  List<Object> get props => [msg];
}
