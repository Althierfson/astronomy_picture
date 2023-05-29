import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Get network information
abstract class NetworkInfo {
  /// if true has connection
  /// if false has no connection
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnection;

  NetworkInfoImpl({required this.internetConnection});

  @override
  Future<bool> get isConnected async => await internetConnection.hasConnection;
}
