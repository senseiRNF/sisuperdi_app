import 'package:dio/dio.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/employee_response.dart';
import 'package:sisuperdi_app/backend/services/init_services.dart';

class EmployeeServices {
  Future<EmployeeResponse?> readAllEmployee() async {
    EmployeeResponse? result;

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-all-employee.php',
        ).then((dioResult) {
          result = EmployeeResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}