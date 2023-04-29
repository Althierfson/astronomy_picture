import 'package:astronomy_picture/core/util/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
void main() {
  late MockInternetConnectionChecker internetConnection;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    internetConnection = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(internetConnection: internetConnection);
  });

  test("Should return an true if has connection", () async {
    when(internetConnection.hasConnection).thenAnswer((_) async => true);

    final result = await networkInfo.isConnected;

    expect(result, true);
  });

  test("Should return an false if has no connection", () async {
    when(internetConnection.hasConnection).thenAnswer((_) async => false);

    final result = await networkInfo.isConnected;

    expect(result, false);
  });
}
