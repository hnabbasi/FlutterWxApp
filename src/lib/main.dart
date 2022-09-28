
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwxapp/features/alerts/bloc/alerts_cubit.dart';
import 'package:flutterwxapp/features/alerts/repositories/api_alerts_repository.dart';
import 'package:flutterwxapp/features/alerts/views/pages/alerts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Alerts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AlertsCubit(ApiAlertsRepository()),
        child: AlertsPage(),
      )
    );
  }
}