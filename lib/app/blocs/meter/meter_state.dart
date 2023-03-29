part of 'meter_bloc.dart';

abstract class MeterState extends Equatable {
  const MeterState();
}

class MeterInitial extends MeterState {
  @override
  List<Object> get props => [];
}

class MeterLoading extends MeterState {
  @override
  List<Object> get props => [];
}

class MeterRetrieved extends MeterState {
  const MeterRetrieved();

  @override
  List<Object> get props => [];
}

class MeterLoaded extends MeterState {
  const MeterLoaded(this.model);
  final RecordResponseModel model;

  @override
  List<Object> get props => [model];
}

class AddMeterLoaded extends MeterState {
  const AddMeterLoaded(this.model);
  final AddRecordResponseModel model;

  @override
  List<Object> get props => [model];
}


class MeterError extends MeterState {
  final String error;

  const MeterError(this.error);

  @override
  List<Object> get props => [error];
}