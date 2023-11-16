import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_wx/configs/api.dart';

class AlertService {

  /// Get alerts for give state code (e.g. TX)
  Future<List<Alert>> getAlerts(String stateCode) async {
    final res = await http.get(Uri(scheme:Api.scheme, host: Api.host, path:"${Api.alerts}/$stateCode"));
    if(res.statusCode != 200){
      return List.empty();
    }
    final map = jsonDecode(res.body);
    final List features = map["features"];

    if (kDebugMode) {
      print("[Service] Found ${features.length} alerts for $stateCode");
    }
    return List.generate(features.length, (index) => Alert.fromJson(features[index]["properties"]!));
  }
}