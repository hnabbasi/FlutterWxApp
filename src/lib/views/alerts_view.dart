import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wx/viewmodels/alerts/alerts_viewmodel.dart';
import 'package:flutter_wx/views/widgets/alerts_widget.dart';
import 'package:provider/provider.dart';

import '../util/text_helpers.dart';

class AlertsPage extends StatelessWidget {
  AlertsPage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      title: Consumer<AlertsViewModel>(
        builder: (context, provider, child) => Text(provider.title)
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<AlertsViewModel>(
            builder: (context, provider, child) =>
                Column(children: <Widget>[
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
                          onPressed: () {
                          _controller.clear();
                          provider.clearAlerts();
                          }),
                        ),
                        onChanged: (stateCode) async {
                          if(stateCode.length < 2) {
                            return;
                          }
                          await provider.getAlerts(stateCode);
                        },
                      )
                ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(provider.status),
                  ),
                  provider.isBusy
                      ? const CircularProgressIndicator()
                      : Expanded(
                      child: AlertsWidget(alerts: provider.alerts)
                  ),
        ]),
      ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

