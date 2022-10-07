import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'alerts_provider.dart';

final alertsCountProvider = StateProvider<int>((ref) => ref.watch(alertsProvider).value?.length ?? 0);