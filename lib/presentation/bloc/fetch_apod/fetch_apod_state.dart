part of 'fetch_apod_bloc.dart';

abstract class FetchApodState extends Equatable {
  const FetchApodState();

  @override
  List<Object> get props => [];
}

class FetchApodInitial extends FetchApodState {}

class LoadingFetchApodState extends FetchApodState {}

class ErrorFetchApodState extends FetchApodState {
  final String msg;

  const ErrorFetchApodState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class SuccessListFetchApod extends FetchApodState {
  final List<Apod> list;

  const SuccessListFetchApod({required this.list});

  @override
  List<Object> get props => [list];
}
