class DestinationResponse {
  int? status;
  String? message;
  List<DestinationResponseData>? data;

  DestinationResponse({this.status, this.message, this.data});

  DestinationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DestinationResponseData>[];
      json['data'].forEach((v) {
        data!.add(DestinationResponseData.fromJson(v));
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

class DestinationResponseData {
  String? idTujuan;
  String? tujuan;

  DestinationResponseData({this.idTujuan, this.tujuan});

  DestinationResponseData.fromJson(Map<String, dynamic> json) {
    idTujuan = json['id_tujuan'];
    tujuan = json['tujuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tujuan'] = idTujuan;
    data['tujuan'] = tujuan;
    return data;
  }
}