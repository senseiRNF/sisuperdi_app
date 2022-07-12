import 'package:dio/dio.dart';
import 'package:sisuperdi_app/backend/class_data/report_class.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/report_response.dart';
import 'package:sisuperdi_app/backend/services/init_services.dart';

class ReportServices {
  Future<bool> writeReport(ReportClass report) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id_spt': report.sptId,
      'id_pegawai': report.employeeId,
      'hasil': report.result,
      'hari': report.day,
      'tanggal': report.date,
    });

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/write-report.php',
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

  Future<ReportResponse?> readReportByUser(int id) async {
    ReportResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-report-by-user.php',
          queryParameters: {
            'id': id,
          },
        ).then((dioResult) {
          result = ReportResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}