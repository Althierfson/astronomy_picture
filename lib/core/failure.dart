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

/// is no possible convert date
class ConvertFailure extends Failure {
  @override
  String get msg => "Sorry! Your query is not in the right format";
}

/// is no possible save data
class SaveDataFailure extends Failure {
  @override
  String get msg => "Sorry! There was a problem when saving";
}

/// is no possible remove data
class RemoveDataFailure extends Failure {
  @override
  String get msg => "Sorry! There was a problem when removing";
}

/// is no possible acesse local data
class AccessLocalDataFailure extends Failure {
  @override
  String get msg => "Sorry! There was a problem accessing local data";
}