class RiwayatKehadiran {
  String? mataKuliah;
  String? kodeMatkul;
  String? namaDosen;
  List<Kehadiran>? kehadiran;
  String? id;

  RiwayatKehadiran(
      {this.mataKuliah,
      this.kodeMatkul,
      this.namaDosen,
      this.kehadiran,
      this.id});

  RiwayatKehadiran.fromJson(Map<String, dynamic> json) {
    mataKuliah = json['mata_kuliah'];
    kodeMatkul = json['kode_matkul'];
    namaDosen = json['nama_dosen'];
    if (json['kehadiran'] != null) {
      kehadiran = <Kehadiran>[];
      json['kehadiran'].forEach((v) {
        kehadiran!.add(new Kehadiran.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mata_kuliah'] = this.mataKuliah;
    data['kode_matkul'] = this.kodeMatkul;
    data['nama_dosen'] = this.namaDosen;
    if (this.kehadiran != null) {
      data['kehadiran'] = this.kehadiran!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Kehadiran {
  int? hadir;
  int? alpa;
  int? sakit;
  int? izin;
  int? dispensasi;

  Kehadiran({this.hadir, this.alpa, this.sakit, this.izin, this.dispensasi});

  Kehadiran.fromJson(Map<String, dynamic> json) {
    hadir = json['Hadir'];
    alpa = json['Alpa'];
    sakit = json['Sakit'];
    izin = json['Izin'];
    dispensasi = json['Dispensasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Hadir'] = this.hadir;
    data['Alpa'] = this.alpa;
    data['Sakit'] = this.sakit;
    data['Izin'] = this.izin;
    data['Dispensasi'] = this.dispensasi;
    return data;
  }
}
