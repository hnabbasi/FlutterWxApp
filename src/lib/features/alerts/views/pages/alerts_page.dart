import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwxapp/features/alerts/bloc/alerts_cubit.dart';

import '../../../../core/helpers/upper_case_text_formatter.dart';
import '../widgets/alerts_list_view_widget.dart';

class AlertsPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AlertsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        BlocProvider.of<AlertsCubit>(context).reset();
                      },
                    )
                ),
                onChanged: (stateCode) async {
                  if(stateCode.isEmpty){
                    BlocProvider.of<AlertsCubit>(context).reset();
                  }
                  if(stateCode.length < 2) {
                    return;
                  }
                  BlocProvider.of<AlertsCubit>(context).getAlerts(stateCode);
                },
              ),
            ),
            Container(
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<AlertsCubit, AlertsState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case AlertsLoaded:
                        return Text((state as AlertsLoaded).status);
                      default:
                        return const Text("");
                    }
                  }
                )
            ),
            BlocBuilder<AlertsCubit, AlertsState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case AlertsLoaded:
                      return Expanded(
                          child: AlertsListViewWidget(alerts: (state as AlertsLoaded).alerts)
                      );
                    case AlertsLoading:
                      return const CircularProgressIndicator();
                    case AlertsError:
                      return Text((state as AlertsError).errMessage);
                    default:
                      return const Text("");
                  }
                }
            )
          ]
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}