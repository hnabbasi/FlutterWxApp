import 'package:flutter/material.dart';

import '../../models/alert.dart';
import '../../models/severity.dart';

class AlertListItemWidget extends StatelessWidget {
  final Alert alert;
  const AlertListItemWidget({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSevere = alert.severity == Severity.severe;
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: isSevere ? Colors.deepOrange : Colors.amber),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSevere ? const Icon(Icons.warning, color: Colors.white) : const Icon(Icons.info, color: Colors.white),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(alert.headline,
                        style: const TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.fade)
                )
            ),
          ],
        )
    );
  }
}