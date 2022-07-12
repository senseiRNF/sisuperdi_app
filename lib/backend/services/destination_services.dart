import 'package:dio/dio.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/destination_response.dart';
import 'package:sisuperdi_app/backend/services/init_services.dart';

class DestinationServices {
  Future<DestinationResponse?> readAllDestination() async {
    DestinationResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-all-destination.php',
        ).then((dioResult) {
          result = DestinationResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}