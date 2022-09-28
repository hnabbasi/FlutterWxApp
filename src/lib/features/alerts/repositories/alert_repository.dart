import '../models/alert.dart';

abstract class AlertsRepository {
  Future<List<Alert>> getAlerts(String stateCode);
}