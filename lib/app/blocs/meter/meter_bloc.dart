import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:water_quality/data/models/add_record_response_model.dart';

import '../../../data/models/record_response_model.dart';
import '../../repositories/meter/meter_repository.dart';

part 'meter_event.dart';
part 'meter_state.dart';

class MeterBloc extends Bloc<MeterEvent, MeterState> {
  final MeterRepository _repository;

  MeterBloc(this._repository) : super(MeterInitial()) {
    on<GetMeterIdEvent>(_getMeterId);
    on<AddMeterEvent>(_addMeter);
    on<GetAllRecordEvent>(_getAllRecord);
  }

  Future<void> _getMeterId(GetMeterIdEvent event, Emitter<MeterState> emit) async {
    emit(MeterLoading());
    try {
      await _repository.getMeterId(event.meterName, event.password);
      emit(const MeterRetrieved());
    } catch (e) {
      debugPrint(e.toString());
      emit(MeterError(e.toString()));
    }
  }

  Future<void> _getAllRecord(GetAllRecordEvent event, Emitter<MeterState> emit) async {
    emit(MeterLoading());
    try {
      RecordResponseModel model = await _repository.getMeterById();
      emit(MeterLoaded(model));
    } catch (e) {
      debugPrint(e.toString());
      emit(MeterError(e.toString()));
    }
  }

  Future<void> _addMeter(AddMeterEvent event, Emitter<MeterState> emit) async {
    emit(MeterLoading());
    try {
      AddRecordResponseModel model = await _repository.addMeterRecord(event.data);
      emit(AddMeterLoaded(model));
    } catch (e) {
      debugPrint(e.toString());
      emit(MeterError(e.toString()));
    }
  }
}
