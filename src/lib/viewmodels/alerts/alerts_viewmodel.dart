import 'package:flutter/foundation.dart';
import 'package:flutter_wx/services/alerts/alert_service.dart';

import '../../models/alert.dart';

class AlertsViewModel extends ChangeNotifier {

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  set isBusy(bool isBusy) {
    _isBusy = isBusy;
    notifyListeners();
  }

  String _title = "";
  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String _status = "";
  String get status => _status;
  set status(String status) {
    _status = status;
    notifyListeners();
  }

  List<Alert> _alerts = List.empty();
  List<Alert> get alerts => _alerts;
  set alerts(List<Alert> alerts) {
    alerts.sort((a,b) => a.severity.toInt.compareTo(b.severity.toInt));
    _alerts = alerts;
    notifyListeners();
  }

  final AlertService alertService;

  AlertsViewModel({required this.alertService}){
    title = "Weather Alerts";
  }

  Future<void> getAlerts(String stateCode) async {
    try{
      isBusy = true;
      alerts = await alertService.geAlerts(stateCode.toUpperCase());
      status = alerts.isNotEmpty
          ? "Found ${alerts.length} active alerts"
          : "No active alerts found";
    } catch(ex) {
      if(kDebugMode) {
        print(ex);
      }
    } finally {
      isBusy = false;
    }
  }

  void clearAlerts(){
    isBusy = false;
    alerts = List.empty();
    status = "";
  }
}