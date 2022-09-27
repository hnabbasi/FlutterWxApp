import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wx/services/alerts/alert_service.dart';
import 'package:flutter_wx/viewmodels/alerts/alerts_viewmodel.dart';
import 'package:provider/provider.dart';

import 'views/alerts_view.dart';

void main() {
  runZonedGuarded(() {
    runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<AlertsViewModel>(
            create:(_) => AlertsViewModel(alertService: AlertService())
        ),
      ],
      child: const MyApp()
      )
    );
    }, (error, stack) {
    throw error;
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlertsPage(),
    );
  }
}
