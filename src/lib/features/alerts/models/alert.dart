
import '../enums/severity.dart';

class Alert {
  String id;
  DateTime sent;
  String event;
  String headline;
  Severity severity;

  Alert({
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