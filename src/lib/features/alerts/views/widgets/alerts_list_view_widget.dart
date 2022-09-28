import 'package:flutter/cupertino.dart';

import '../../models/alert.dart';
import 'alert_list_item_widget.dart';

class AlertsListViewWidget extends StatelessWidget {
  final List<Alert> alerts;

  const AlertsListViewWidget({Key? key, required this.alerts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 540) {
            return GridView.count(
                crossAxisCount: 4,
                children: List.generate(alerts.length, (index) => AlertListItemWidget(alert: alerts[index]))
            );
          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(alerts.length, (index) {
                return AlertListItemWidget(alert: alerts[index]);
              }),
            );
          }
        });
  }
}