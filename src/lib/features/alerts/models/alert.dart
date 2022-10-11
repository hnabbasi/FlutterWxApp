
import 'package:flutter/widgets.dart';

import '../enums/severity.dart';

@immutable
class Alert {
  final String id;
  final DateTime sent;
  final String event;
  final String headline;
  final Severity severity;

  const Alert({
    required this.id,
    required this.sent,
    required this.event,
    required this.headline,
    required this.severity
  });

  Alert.fromJson(Map<String, dynamic> json):
        id = json["id"],
        sent = DateTime.parse(json["sent"]),
        event = json["event"],
        severity = Severity.fromString(json["severity"]),
        headline = json["headline"];
}