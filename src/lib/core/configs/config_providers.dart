import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiBaseUrlProvider = StateProvider<String>((_) => 'api.weather.gov');
final userAgentProvider = StateProvider<Map<String,String>>((_) => {"User-agent": "flutter_app"});