import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wx/services/alerts/alert_service.dart';

void main() {
  test('Empty list is returned for wrong state code', () async {
    final service = AlertService();

    var result = await service.geAlerts("X");
    expect(result.length, 0);
  });
}
