import 'package:dio/dio.dart';
import 'package:sisuperdi_app/backend/class_data/auth_class.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/login_response.dart';
import 'package:sisuperdi_app/backend/functions/shared_preferences.dart';
import 'package:sisuperdi_app/backend/services/init_services.dart';

class AuthServices {
  Future<bool> loginUser(AuthClass authClass) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'username': authClass.username,
      'password': authClass.password,
    });

    await InitServices().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/user-login.php',
          data: formData,
        ).then((dioResult) async {
          LoginUserResponse userResponse = LoginUserResponse.fromJson(dioResult.data);

          if(userResponse.data != null && userResponse.data!.isNotEmpty) {
            await SPrefs().writeAuth(
              AuthClass(
                userId: int.parse(userResponse.data![0].idPegawai!),
                username: userResponse.data![0].username,
                name: userResponse.data![0].nama,
                nip: userResponse.data![0].nip,
                position: userResponse.data![0].jabatan,
                workUnit: userResponse.data![0].unitkerja,
                role: userResponse.role,
              ),
            ).then((prefResult) {
              if(prefResult) {
                result = true;
              }
            });
          } else {
            try {
              await dio.post(
                '/admin-login.php',
                data: formData,
              ).then((dioAdminResult) async {
                LoginAdminResponse adminResponse = LoginAdminResponse.fromJson(dioAdminResult.data);

                if(adminResponse.data != null && adminResponse.data!.isNotEmpty) {
                  await SPrefs().writeAuth(
                    AuthClass(
                      userId: int.parse(adminResponse.data![0].id!),
                      username: adminResponse.data![0].username,
                      position: adminResponse.data![0].level,
                      role: adminResponse.role,
                    ),
                  ).then((prefAdminResult) {
                    result = true;
                  });
                }
              });
            } on DioError catch(_) {

            }
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}