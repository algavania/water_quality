
import '../../../data/models/add_record_response_model.dart';
import '../../../data/models/authentication_response_model.dart';
import '../../../data/models/record_response_model.dart';
import '../../../services/network_service.dart';
import '../../../services/shared_preferences_service.dart';
import 'base_meter_repository.dart';

class MeterRepository extends BaseMeterRepository {
  @override
  Future<RecordResponseModel> getMeterById() async {
    String id = SharedPreferencesService.getMeterId() ?? '';
    final res = await NetworkService.get('/record/$id');
    RecordResponseModel model = recordResponseModelFromJson(res.body);
    if (res.statusCode != 200) {
      throw model.data?.first.message ?? 'Error';
    }
    return model;
  }

  @override
  Future<void> getMeterId(String meterName, String password) async {
    final res = await NetworkService.post('/meter/retriveid',
        {'meter_name': meterName, 'password': password});
    AuthenticationResponseModel model = authenticationResponseModelFromJson(res.body);
    if (res.statusCode != 200) {
      throw model.data?.message ?? 'Error';
    }
    await SharedPreferencesService.setMeterId(model.data?.meterId ?? '');
  }

  @override
  Future<AddRecordResponseModel> addMeterRecord(MeterData data) async {
    String id = SharedPreferencesService.getMeterId() ?? '';
    final res = await NetworkService.post('/record/$id', data.toJson());
    AddRecordResponseModel model = addRecordResponseModelFromJson(res.body);
    if (res.statusCode != 201) {
      throw model.data?.message ?? 'Error';
    }
    return model;
  }
}