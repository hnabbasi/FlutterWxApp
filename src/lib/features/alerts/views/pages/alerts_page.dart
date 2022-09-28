import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/helpers/upper_cast_text_formatter.dart';
import '../../providers/alerts_provider.dart';
import '../../providers/alerts_status_provider.dart';
import '../../providers/state_code_provider.dart';
import '../widgets/alerts_list_view_widget.dart';

class AlertsPage extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  AlertsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Alerts'),
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
                        blurRadius: 1.0
                    )
                  ]
              ),
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
                        ref.invalidate(stateCodeProvider);
                      },
                    )
                ),
                onChanged: (stateCode) async {
                  if(stateCode.length < 2) {
                    return;
                  }
                  ref.watch(stateCodeProvider.state).state = stateCode;
                },
              ),
            ),
            Container(
                padding: const EdgeInsets.all(10),
                child: Text(ref.watch(alertsStatusProvider))
            ),
            ref.watch(alertsProvider).when(
                data: (d) {
                  return Expanded(
                      child: AlertsListViewWidget(alerts: d)
                  );
                },
                error: (err, _) => Text(err.toString()),
                loading: () => const CircularProgressIndicator())
          ]
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}