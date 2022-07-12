class NPPDResponse {
  int? status;
  String? message;
  List<NPPDResponseData>? data;

  NPPDResponse({this.status, this.message, this.data});

  NPPDResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NPPDResponseData>[];
      json['data'].forEach((v) {
        data!.add(NPPDResponseData.fromJson(v));
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

class NPPDResponseData {
  String? idNppt;
  String? idPegawai;
  String? idTujuan;
  String? maksud;
  String? idTransportasi;
  String? lama;
  String? tglPergi;
  String? tglKembali;
  String? status;
  String? nama;
  String? tujuan;

  NPPDResponseData({
    this.idNppt,
    this.idPegawai,
    this.idTujuan,
    this.maksud,
    this.idTransportasi,
    this.lama,
    this.tglPergi,
    this.tglKembali,
    this.status,
    this.nama,
    this.tujuan,
  });

  NPPDResponseData.fromJson(Map<String, dynamic> json) {
    idNppt = json['id_nppt'];
    idPegawai = json['id_pegawai'];
    idTujuan = json['id_tujuan'];
    maksud = json['maksud'];
    idTransportasi = json['id_transportasi'];
    lama = json['lama'];
    tglPergi = json['tgl_pergi'];
    tglKembali = json['tgl_kembali'];
    status = json['status'];
    nama = json['nama'];
    tujuan = json['tujuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_nppt'] = idNppt;
    data['id_pegawai'] = idPegawai;
    data['id_tujuan'] = idTujuan;
    data['maksud'] = maksud;
    data['id_transportasi'] = idTransportasi;
    data['lama'] = lama;
    data['tgl_pergi'] = tglPergi;
    data['tgl_kembali'] = tglKembali;
    data['status'] = status;
    data['nama'] = nama;
    data['tujuan'] = tujuan;
    return data;
  }
}