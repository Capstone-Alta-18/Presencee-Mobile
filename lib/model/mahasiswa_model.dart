class MahasiswaModel {
  List<Mahasiswas>? mahasiswas;
  String? status;

  MahasiswaModel({this.mahasiswas, this.status});

  MahasiswaModel.fromJson(Map<String, dynamic> json) {
    if (json['mahasiswas'] != null) {
      mahasiswas = <Mahasiswas>[];
      json['mahasiswas'].forEach((v) {
        mahasiswas!.add(new Mahasiswas.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mahasiswas != null) {
      data['mahasiswas'] = this.mahasiswas!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Mahasiswas {
  int? iD;
  String? createdAt;
  String? updatedAt;
  // Null? deletedAt;
  String? name;
  String? email;
  String? nim;
  String? image;
  String? phone;
  String? jurusan;
  String? tahunMasuk;
  String? ipk;
  int? userId;

  Mahasiswas({
    this.iD,
    this.createdAt,
    this.updatedAt,
    // this.deletedAt,
    this.name,
    this.email,
    this.nim,
    this.image,
    this.phone,
    this.jurusan,
    this.tahunMasuk,
    this.ipk,
    this.userId
  });

  Mahasiswas.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    // deletedAt = json['DeletedAt'];
    name = json['name'];
    email = json['email'];
    nim = json['nim'];
    image = json['image'];
    phone = json['phone'];
    jurusan = json['jurusan'];
    tahunMasuk = json['tahun_masuk'];
    ipk = json['ipk'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    // data['DeletedAt'] = this.deletedAt;
    data['name'] = this.name;
    data['email'] = this.email;
    data['nim'] = this.nim;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['jurusan'] = this.jurusan;
    data['tahun_masuk'] = this.tahunMasuk;
    data['ipk'] = this.ipk;
    data['user_id'] = this.userId;
    return data;
  }
}
