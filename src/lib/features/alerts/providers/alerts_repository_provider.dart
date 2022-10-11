import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/alert_repository.dart';
import '../repositories/api_alert_repository.dart';

final alertsRepositoryProvider = Provider<AlertsRepository>((ref) => ApiAlertsRepository());