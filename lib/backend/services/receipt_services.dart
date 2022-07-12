import 'package:dio/dio.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/receipt_response.dart';
import 'package:sisuperdi_app/backend/services/init_services.dart';

class ReceiptServices {
  Future<ReceiptResponse?> readReceiptByUser(int id) async {
    ReceiptResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-receipt-by-user.php',
          queryParameters: {
            'id': id,
          },
        ).then((dioResult) {
          result = ReceiptResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}