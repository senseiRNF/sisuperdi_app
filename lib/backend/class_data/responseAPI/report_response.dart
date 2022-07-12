class ReportResponse {
  int? status;
  String? message;
  List<ReportResponseData>? data;

  ReportResponse({this.status, this.message, this.data});

  ReportResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReportResponseData>[];
      json['data'].forEach((v) {
        data!.add(ReportResponseData.fromJson(v));
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

class ReportResponseData {
  String? idLpd;
  String? idSpt;
  String? idPegawai;
  String? hasil;
  String? hari;
  String? tanggal;
  String? nama;

  ReportResponseData({
    this.idLpd,
    this.idSpt,
    this.idPegawai,
    this.hasil,
    this.hari,
    this.tanggal,
    this.nama,
  });

  ReportResponseData.fromJson(Map<String, dynamic> json) {
    idLpd = json['id_lpd'];
    idSpt = json['id_spt'];
    idPegawai = json['id_pegawai'];
    hasil = json['hasil'];
    hari = json['hari'];
    tanggal = json['tanggal'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_lpd'] = idLpd;
    data['id_spt'] = idSpt;
    data['id_pegawai'] = idPegawai;
    data['hasil'] = hasil;
    data['hari'] = hari;
    data['tanggal'] = tanggal;
    data['nama'] = nama;
    return data;
  }
}