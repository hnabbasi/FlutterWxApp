import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwxapp/features/alerts/models/alert.dart';
import 'package:http/http.dart' as http;

import '../../../core/configs/config_providers.dart';
import 'alert_repository.dart';

class ApiAlertsRepository implements AlertsRepository {

  String apiBaseUrl = "";
  Map<String,String> headers = {};

  ApiAlertsRepository(Ref ref){
    apiBaseUrl = ref.read(apiBaseUrlProvider);
    headers = ref.read(userAgentProvider);
  }

  @override
  Future<List<Alert>> getAlerts(String stateCode) async {
    final res = await http.get(Uri.https(apiBaseUrl, "/alerts/active/area/$stateCode"), headers: headers);
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