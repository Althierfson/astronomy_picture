part of 'fetch_apod_bloc.dart';

abstract class FetchApodEvent extends Equatable {
  const FetchApodEvent();

  @override
  List<Object> get props => [];
}

class MakeFetchApodEvent extends FetchApodEvent {}
