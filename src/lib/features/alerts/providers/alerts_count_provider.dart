import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'alerts_provider.dart';

final alertsCountProvider = StateProvider<int>((ref) {
  final alerts = ref.watch(alertsProvider);
  return alerts.value?.length ?? 0;
});