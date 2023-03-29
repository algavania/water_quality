
import '../../../data/models/add_record_response_model.dart';
import '../../../data/models/record_response_model.dart';

abstract class BaseMeterRepository {
  Future<void> getMeterId(String meterName, String password);
  Future<RecordResponseModel> getMeterById();
  Future<AddRecordResponseModel> addMeterRecord(MeterData data);
}