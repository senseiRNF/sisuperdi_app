import 'package:dio/dio.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/transportation_response.dart';
import 'package:sisuperdi_app/backend/services/init_services.dart';

class TransportationServices {
  Future<TransportationResponse?> readAllTransportation() async {
    TransportationResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-all-transportation.php',
        ).then((dioResult) {
          result = TransportationResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}