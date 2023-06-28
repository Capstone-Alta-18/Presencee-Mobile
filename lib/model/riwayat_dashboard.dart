class RiwayatDashboard {
  String? message;
  Meta? meta;
  int? totalCount;

  RiwayatDashboard({this.message, this.meta, this.totalCount});

  RiwayatDashboard.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['total_count'] = this.totalCount;
    return data;
  }
}

class Meta {
  int? alpa;
  int? dispensasi;
  int? hadir;
  int? izin;
  int? sakit;

  Meta({this.alpa, this.dispensasi, this.hadir, this.izin, this.sakit});

  Meta.fromJson(Map<String, dynamic> json) {
    alpa = json['Alpa'];
    dispensasi = json['Dispensasi'];
    hadir = json['Hadir'];
    izin = json['Izin'];
    sakit = json['Sakit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Alpa'] = this.alpa;
    data['Dispensasi'] = this.dispensasi;
    data['Hadir'] = this.hadir;
    data['Izin'] = this.izin;
    data['Sakit'] = this.sakit;
    return data;
  }
}
