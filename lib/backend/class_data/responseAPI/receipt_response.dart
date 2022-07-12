class ReceiptResponse {
  int? status;
  String? message;
  List<ReceiptResponseData>? data;

  ReceiptResponse({this.status, this.message, this.data});

  ReceiptResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReceiptResponseData>[];
      json['data'].forEach((v) {
        data!.add(ReceiptResponseData.fromJson(v));
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

class ReceiptResponseData {
  String? idKwitansi;
  String? idSppd;
  String? idPegawai;
  String? dari;
  String? untuk;
  String? lama;
  String? lumpsum;
  String? penginapan;
  String? transportasi;
  String? tujuan;
  String? nama;

  ReceiptResponseData({
    this.idKwitansi,
    this.idSppd,
    this.idPegawai,
    this.dari,
    this.untuk,
    this.lama,
    this.lumpsum,
    this.penginapan,
    this.transportasi,
    this.tujuan,
    this.nama,
  });

  ReceiptResponseData.fromJson(Map<String, dynamic> json) {
    idKwitansi = json['id_kwitansi'];
    idSppd = json['id_sppd'];
    idPegawai = json['id_pegawai'];
    dari = json['dari'];
    untuk = json['untuk'];
    lama = json['lama'];
    lumpsum = json['lumpsum'];
    penginapan = json['penginapan'];
    transportasi = json['transportasi'];
    tujuan = json['tujuan'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_kwitansi'] = idKwitansi;
    data['id_sppd'] = idSppd;
    data['id_pegawai'] = idPegawai;
    data['dari'] = dari;
    data['untuk'] = untuk;
    data['lama'] = lama;
    data['lumpsum'] = lumpsum;
    data['penginapan'] = penginapan;
    data['transportasi'] = transportasi;
    data['tujuan'] = tujuan;
    data['nama'] = nama;
    return data;
  }
}