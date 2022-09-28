import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwxapp/features/alerts/providers/state_code_provider.dart';

import 'alerts_count_provider.dart';

final alertsStatusProvider = StateProvider<String>((ref) {
  final stateCode = ref.watch(stateCodeProvider);

  if(stateCode == "") {
    return "";
  }

  final alerts = ref.watch(alertsCountProvider);
  return alerts > 0
      ? "Found ${ref.watch(alertsCountProvider)} alerts"
      : "No active alerts found.";
});
