import 'package:flutter/foundation.dart';
import 'package:flutter_wx/services/alert_service.dart';

import '../models/alert.dart';

class MainViewModel extends ChangeNotifier {
  final AlertService service;

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
    _alerts = alerts;
    notifyListeners();
  }

  MainViewModel({required this.service}){
    title = "Weather Alerts";
  }

  Future<void> getAlerts(String stateCode) async {
    try{
      isBusy = true;
      alerts = await service.geAlerts(stateCode.toUpperCase());
    } catch(ex) {
      if(kDebugMode) {
        print(ex);
      }
    }
    isBusy = false;
  }
}