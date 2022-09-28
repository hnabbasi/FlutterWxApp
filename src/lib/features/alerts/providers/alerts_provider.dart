import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwxapp/features/alerts/providers/state_code_provider.dart';

import '../models/alert.dart';
import 'alerts_repository_provider.dart';

final alertsProvider = FutureProvider<List<Alert>>((ref) async {
  var stateCode = ref.watch(stateCodeProvider);

  final alerts = await ref.watch(alertsRepositoryProvider).getAlerts(stateCode);

  if(alerts.isNotEmpty){
    alerts.sort((a,b) => a.severity.toInt.compareTo(b.severity.toInt));
  }

  return alerts;
});