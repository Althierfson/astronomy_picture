import 'package:equatable/equatable.dart';

abstract class SuccessReturn extends Equatable{
  String get msg;

  @override
  List<Object?> get props => [msg];
}

// Apod Date was save
class ApodSave extends SuccessReturn {
  @override
  String get msg => "Saved content";
}

// Apod Date was save
class ApodSaveRemoved extends SuccessReturn {
  @override
  String get msg => "Content removed";
}