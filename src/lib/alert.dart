class Alert {
  String id;
  DateTime sent;
  String event;
  String headline;

  Alert({
    required this.id,
    required this.sent,
    required this.event,
    required this.headline
  });

  Alert.fromJson(Map<String, dynamic> json):
    id = json["id"],
    sent = DateTime.parse(json["sent"]),
    event = json["event"],
    headline = json["headline"];
}