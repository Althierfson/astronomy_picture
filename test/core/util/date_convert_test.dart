import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/date_convert.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Should return a String from a DateTime", () {
    final result = DateConvert.dateToString(DateTime(2023, 5, 5));

    expect(result, "2023-05-05");
  });

  group("func - toApodStandard", () {
    test("Should return a String from a query String", () {
      final result = DateConvert.toApodStandard("2022-05-05/2022-05-01");

      result.fold((l) {
        expect(1, 2);
      }, (r) {
        expect(r, {'start': '2022-05-05', 'end': '2022-05-01'});
      });
    });

    test("Should return a String on the Right of Either from a query String",
        () {
      final result = DateConvert.toApodStandard("2022-05-05");

      result.fold((l) {
        expect(1, 2);
      }, (r) {
        expect(r, {'start': '2022-05-05', 'end': null});
      });
    });

    test(
        "Should return a Failure on the Lefth of Either from wrong query String",
        () {
      final result = DateConvert.toApodStandard("2022-05-5/2022-05-01");

      result.fold((l) {
        expect(l, isA<ConvertFailure>());
      }, (r) {
        expect(1, 2);
      });
    });
  });
}
