import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterwxapp/features/alerts/models/alert.dart';
import 'package:http/http.dart' as http;

import '../../../core/configs/configs.dart';
import 'alerts_repository.dart';


class ApiAlertsRepository implements AlertsRepository {

  @override
  Future<List<Alert>> getAlerts(String stateCode) async {
    final res = await http.get(Uri.https(Configs.apiBaseUrl, "/alerts/active/area/$stateCode"), headers: Configs.headers);
    if(res.statusCode != 200){
      return List.empty();
    }

    final map = jsonDecode(res.body);
    final List features = map["features"];

    if(kDebugMode){
      print("[Repository] Found ${features.length} alerts");
    }

    return List.generate(features.length, (index) => Alert.fromJson(features[index]["properties"]!));
  }
}