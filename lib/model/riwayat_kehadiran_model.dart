class RiwayatKehadiran {
  String? message;
  Meta? meta;

  RiwayatKehadiran({this.message, this.meta});

  RiwayatKehadiran.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Meta {
  Akuntansi? akuntansi;
  Akuntansi? bahasaIndonesia;
  Akuntansi? ilustrasi;
  Akuntansi? mathematics;
  Akuntansi? ppkn;
  Akuntansi? agama;
  // AgamaDosen? agamaDosen;

  Meta(
      {this.akuntansi, this.bahasaIndonesia, this.ilustrasi, this.mathematics});

  Meta.fromJson(Map<String, dynamic> json) {
    akuntansi = json['Akuntansi'] != null
        ? Akuntansi.fromJson(json['Akuntansi'])
        : null;
    bahasaIndonesia = json['Bahasa Indonesia'] != null
        ? Akuntansi.fromJson(json['Bahasa Indonesia'])
        : null;
    ilustrasi = json['Ilustrasi'] != null
        ? Akuntansi.fromJson(json['Ilustrasi'])
        : null;
    mathematics = json['Mathematics'] != null
        ? Akuntansi.fromJson(json['Mathematics'])
        : null;
    agama = json['Agama'] != null
        ? Akuntansi.fromJson(json['Agama'])
        : null;
    ppkn = json['PPKN'] != null
        ? Akuntansi.fromJson(json['PPKN'])
        : null;
    // agamaDosen = json['Agama_Dosen'] != null
    //     ? AgamaDosen.fromJson(json['Agama_Dosen'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (akuntansi != null) {
      data['Akuntansi'] = akuntansi!.toJson();
    }
    if (bahasaIndonesia != null) {
      data['Bahasa Indonesia'] = bahasaIndonesia!.toJson();
    }
    if (ppkn != null) {
      data['PPKN'] = ppkn!.toJson();
    }
    if (agama != null) {
      data['Agama'] = agama!.toJson();
    }
    if (ilustrasi != null) {
      data['Ilustrasi'] = ilustrasi!.toJson();
    }
    if (mathematics != null) {
      data['Mathematics'] = mathematics!.toJson();
    }
    // if (agamaDosen != null) {
    //   data['Agama_Dosen'] = agamaDosen!.toJson();
    // }
    return data;
  }
}

class Akuntansi {
  int? alpa;
  int? dispensasi;
  int? hadir;
  int? izin;
  int? sakit;
  int? total;

  Akuntansi(
      {this.alpa,
      this.dispensasi,
      this.hadir,
      this.izin,
      this.sakit,
      this.total});

  Akuntansi.fromJson(Map<String, dynamic> json) {
    alpa = json['Alpa'];
    dispensasi = json['Dispensasi'];
    hadir = json['Hadir'];
    izin = json['Izin'];
    sakit = json['Sakit'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Alpa'] = alpa;
    data['Dispensasi'] = dispensasi;
    data['Hadir'] = hadir;
    data['Izin'] = izin;
    data['Sakit'] = sakit;
    data['Total'] = total;
    return data;
  }
}
