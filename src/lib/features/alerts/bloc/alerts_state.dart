part of 'alerts_cubit.dart';

abstract class AlertsState extends Equatable {
  const AlertsState();
}

class AlertsInitial extends AlertsState {
  @override
  List<Object> get props => [];
}

class AlertsLoading extends AlertsState {
  @override
  List<Object> get props => [];
}

class AlertsLoaded extends AlertsState {
  final List<Alert> alerts;
  final String status;

  const AlertsLoaded(this.alerts, this.status);

  @override
  List<Object> get props => [alerts, status];

  @override
  bool operator ==(Object other){
    if (identical(this, 0)) return true;
    return other is AlertsLoaded && other.alerts == alerts && other.status == status;
  }

  @override
  int get hashCode => alerts.hashCode;
}

class AlertsError extends AlertsState {
  final String errMessage;

  const AlertsError(this.errMessage);

  @override
  List<Object> get props => [errMessage];

  @override
  bool operator ==(Object other){
    if (identical(this, 0)) return true;
    return other is AlertsError && other.errMessage == errMessage;
  }

  @override
  int get hashCode => errMessage.hashCode;
}
