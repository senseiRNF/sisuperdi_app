import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:sisuperdi_app/backend/class_data/nppd_class.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/nppd_response.dart';
import 'package:sisuperdi_app/backend/services/init_services.dart';

class NPPDServices {
  Future<bool> writeNPPD(NPPDClass nppd) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id_user': nppd.userId,
      'id_tujuan': nppd.destinationId,
      'tgl_berangkat': DateFormat('yyyy-MM-dd').format(nppd.departureDate!),
      'tgl_kembali': DateFormat('yyyy-MM-dd').format(nppd.arrivalDate!),
      'durasi': nppd.duration,
      'id_transportasi': nppd.transportationId,
      'maksud': nppd.intend,
    });

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/write-nppd.php',
          data: formData,
        ).then((dioResult) {
          if(dioResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<NPPDResponse?> readAllNPPD() async {
    NPPDResponse? response;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-all-nppt.php',
        ).then((dioResult) {
          response = NPPDResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return response;
  }

  Future<NPPDResponse?> readNPPDByUser(int id) async {
    NPPDResponse? response;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-nppt-by-user.php',
          queryParameters: {
            'id': id,
          },
        ).then((dioResult) {
          response = NPPDResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return response;
  }

  Future<bool> updateNPPDStatus(int id, String status) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id': id,
      'status': status,
    });

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/update-nppd-status.php',
          data: formData,
        ).then((dioResult) {
          if(dioResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}