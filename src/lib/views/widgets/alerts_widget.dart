import 'package:flutter/material.dart';

import '../../models/alert.dart';
import 'alert_widget.dart';

class AlertsWidget extends StatelessWidget {
  final List<Alert> alerts;

  const AlertsWidget({Key? key, required this.alerts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 540) {
            return GridView.count(
                crossAxisCount: 4,
                children: List.generate(alerts.length, (index) => AlertWidget(alert: alerts[index]))
            );
          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(alerts.length, (index) {
                return AlertWidget(alert: alerts[index]);
              }),
            );
          }
        });
  }
}