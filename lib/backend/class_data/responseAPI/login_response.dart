class LoginUserResponse {
  int? status;
  String? message;
  List<LoginUserResponseData>? data;
  String? role;

  LoginUserResponse({this.status, this.message, this.data, this.role});

  LoginUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LoginUserResponseData>[];
      json['data'].forEach((v) {
        data!.add(LoginUserResponseData.fromJson(v));
      });
    }
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['role'] = role;
    return data;
  }
}

class LoginUserResponseData {
  String? idPegawai;
  String? nip;
  String? nama;
  String? pangkat;
  String? idGolongan;
  String? jabatan;
  String? unitkerja;
  String? username;
  String? password;

  LoginUserResponseData({
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

  LoginUserResponseData.fromJson(Map<String, dynamic> json) {
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

class LoginAdminResponse {
  int? status;
  String? message;
  List<LoginAdminResponseData>? data;
  String? role;

  LoginAdminResponse({this.status, this.message, this.data, this.role});

  LoginAdminResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LoginAdminResponseData>[];
      json['data'].forEach((v) {
        data!.add(LoginAdminResponseData.fromJson(v));
      });
    }
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['role'] = role;
    return data;
  }
}

class LoginAdminResponseData {
  String? id;
  String? username;
  String? password;
  String? level;

  LoginAdminResponseData({this.id, this.username, this.password, this.level});

  LoginAdminResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['level'] = level;
    return data;
  }
}