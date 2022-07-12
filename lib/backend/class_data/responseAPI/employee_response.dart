class EmployeeResponse {
  int? status;
  String? message;
  List<EmployeeResponseData>? data;

  EmployeeResponse({this.status, this.message, this.data});

  EmployeeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EmployeeResponseData>[];
      json['data'].forEach((v) {
        data!.add(EmployeeResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeResponseData {
  String? idPegawai;
  String? nip;
  String? nama;
  String? pangkat;
  String? idGolongan;
  String? jabatan;
  String? unitkerja;
  String? username;
  String? password;

  EmployeeResponseData({
    this.idPegawai,
    this.nip,
    this.nama,
    this.pangkat,
    this.idGolongan,
    this.jabatan,
    this.unitkerja,
    this.username,
    this.password,
  });

  EmployeeResponseData.fromJson(Map<String, dynamic> json) {
    idPegawai = json['id_pegawai'];
    nip = json['nip'];
    nama = json['nama'];
    pangkat = json['pangkat'];
    idGolongan = json['id_golongan'];
    jabatan = json['jabatan'];
    unitkerja = json['unitkerja'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pegawai'] = idPegawai;
    data['nip'] = nip;
    data['nama'] = nama;
    data['pangkat'] = pangkat;
    data['id_golongan'] = idGolongan;
    data['jabatan'] = jabatan;
    data['unitkerja'] = unitkerja;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}