import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wx/services/alert_service.dart';
import 'package:flutter_wx/viewmodels/main_viewmodel.dart';
import 'package:flutter_wx/views/widgets/alerts_widget.dart';

import '../util/text_helpers.dart';

final alertsProvider = ChangeNotifierProvider((ref) => MainViewModel(service: AlertService()));

class AlertsPage extends ConsumerWidget {


  AlertsPage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
      title: Text(ref.watch(alertsProvider).title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
              color: Colors.grey,
              offset: Offset(1,1),
              blurRadius: 1.0)
            ]),
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 18),
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
              LengthLimitingTextInputFormatter(2),
              UpperCaseTextFormatter(),
              ],
              decoration: InputDecoration(
                hintText: "ex. TX",
                hintStyle: const TextStyle(color: Colors.blueGrey),
                border: InputBorder.none,
                suffix: IconButton(
                  color: Colors.blueGrey,
                  icon: const Icon(Icons.cancel),
                  onPressed: () async {
                  _controller.clear();
                  await ref.watch(alertsProvider).getAlerts("x");
                  }),
                ),
                onChanged: (stateCode) async {
                  if(stateCode.length < 2) {
                    return;
                  }
                  await ref.watch(alertsProvider).getAlerts(stateCode);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(ref.watch(alertsProvider).status),
              ),
          ref.watch(alertsProvider).isBusy
            ? const CircularProgressIndicator()
            : Expanded(
              child: AlertsWidget(alerts: ref.watch(alertsProvider).alerts)
          )
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

