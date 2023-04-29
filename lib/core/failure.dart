import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get msg;

  @override
  List<Object?> get props => [];
}

/// No internet connection
class NoConnection extends Failure {
  @override
  String get msg => "Sorry! You not have connection!";
}

/// is no possible access API
class ApiFailure extends Failure {
  @override
  String get msg => "Sorry! It was not possible to access the Server";
}
