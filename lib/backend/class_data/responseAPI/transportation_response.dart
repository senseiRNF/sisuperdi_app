class TransportationResponse {
  int? status;
  String? message;
  List<TransportationResponseData>? data;

  TransportationResponse({this.status, this.message, this.data});

  TransportationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TransportationResponseData>[];
      json['data'].forEach((v) {
        data!.add(TransportationResponseData.fromJson(v));
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

class TransportationResponseData {
  String? idTransportasi;
  String? transportasi;

  TransportationResponseData({this.idTransportasi, this.transportasi});

  TransportationResponseData.fromJson(Map<String, dynamic> json) {
    idTransportasi = json['id_transportasi'];
    transportasi = json['transportasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_transportasi'] = idTransportasi;
    data['transportasi'] = transportasi;
    return data;
  }
}