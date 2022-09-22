import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutterwxapp/alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Alerts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Weather Alerts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isBusy = false;
  String _statusText = "";
  final _alerts = List<Alert>.empty(growable: true);

  final TextEditingController _controller = TextEditingController();

  Future<void> getWeather(String stateCode) async {
    isLoading(true);
    final res = await http.get(Uri(scheme:"https", host: "api.weather.gov", path:"alerts/active/area/$stateCode"), headers: {'User-Agent':'flutter'});
    if(res.statusCode != 200){
      setResult(List.empty(), "Error getting alerts for $stateCode");
      isLoading(false);
      return;
    }
    final map = jsonDecode(res.body);
    final List features = map["features"];

    setResult(List.generate(features.length, (index) => Alert.fromJson(features[index]["properties"]!)),
    "Found ${features.length} alerts for $stateCode");
    isLoading(false);
  }

  void setResult(List<Alert> alerts, String status) {
    setState((){
      _statusText = status;
      _alerts.clear();
      _alerts.addAll(alerts);
    });
  }
  void isLoading(bool isBusy) {
    setState((){
      _isBusy = isBusy;
    });
  }

  void reset(){
    setState((){
      _statusText = "";
      _alerts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                        reset();
                      },
                    )
                ),
                onChanged: (stateCode) async {
                  if(stateCode.length < 2) {
                    return;
                  }
                  await getWeather(stateCode);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(_statusText),
            ),
            _isBusy
                ? const CircularProgressIndicator()
                : Expanded(
                  child: AlertWidget(alerts: _alerts)
            )
          ]
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class AlertWidget extends StatelessWidget {
  final List<Alert> alerts;

  const AlertWidget({Key? key, required this.alerts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(alerts.length, (index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: alerts[index].severity.toLowerCase() == "severe" ? Colors.deepOrange : Colors.amber),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              alerts[index].severity.toLowerCase() == "severe" ? const Icon(Icons.warning, color: Colors.white) : const Icon(Icons.info, color: Colors.white),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                      child: Text(alerts[index].headline,
                        style: const TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold),
                          maxLines: 4,
                            overflow: TextOverflow.fade)
                  )
              ),
            ],
          )
        );
      }),
    );
  }
}