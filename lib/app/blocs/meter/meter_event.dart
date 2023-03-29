part of 'meter_bloc.dart';

abstract class MeterEvent extends Equatable {
  const MeterEvent();
}

class GetMeterIdEvent extends MeterEvent {
  const GetMeterIdEvent(this.meterName, this.password);
  final String meterName, password;

  @override
  List<Object?> get props => [meterName, password];
}

class AddMeterEvent extends MeterEvent {
  const AddMeterEvent(this.data);
  final MeterData data;

  @override
  List<Object?> get props => [data];
}

class GetAllRecordEvent extends MeterEvent {
  const GetAllRecordEvent();

  @override
  List<Object?> get props => [];
}
