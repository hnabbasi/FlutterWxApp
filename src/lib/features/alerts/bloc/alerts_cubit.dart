import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/alert.dart';
import '../repositories/alerts_repository.dart';

part 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsState> {
  final AlertsRepository repository;

  AlertsCubit(this.repository) : super(AlertsInitial());

  Future<void> getAlerts(String stateCode) async {
    try{
     emit(AlertsLoading());
     final alerts = await repository.getAlerts(stateCode);
     var status = "No active alerts found";

     if(alerts.isNotEmpty){
       alerts.sort((a,b) => a.severity.toInt.compareTo(b.severity.toInt));
       status = "Found ${alerts.length} alerts";
     }
     emit(AlertsLoaded(alerts, status));
    } on Exception {
      emit(AlertsError("Failed to get alerts for $stateCode"));
    }
  }

  void reset() {
    emit(AlertsInitial());
  }
}