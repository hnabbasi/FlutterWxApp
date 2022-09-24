import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/alerts_view.dart';

void main() {
  runZonedGuarded(() {
    runApp(const ProviderScope(child: MyApp()));
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
