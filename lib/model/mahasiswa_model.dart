
class Mahasiswas {
  final int? iD;
  final String? createdAt;
  final String? updatedAt;
  Null? deletedAt;
  final String? name;
  final String? email;
  final String? nim;
  final String? image;
  final String? phone;
  final String? jurusan;
  final String? tahunMasuk;
  final String? ipk;
  final int? userId;

  Mahasiswas({
    this.iD,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
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

  factory Mahasiswas.fromJson(Map<String, dynamic> json) {
    return Mahasiswas(
      iD: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      name: json['name'],
      email: json['email'],
      nim: json['nim'],
      image: json['image'],
      phone: json['phone'],
      jurusan: json['jurusan'],
      tahunMasuk: json['tahun_masuk'],
      ipk: json['ipk'],
      userId: json['user_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': iD,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
      'DeletedAt': deletedAt,
      'name': name,
      'email': email,
      'nim': nim,
      'image': image,
      'phone': phone,
      'jurusan': jurusan,
      'tahun_masuk': tahunMasuk,
      'ipk': ipk,
      'user_id': userId
    };
  }
}

class MahasiswaStatus {
  String? status;

  MahasiswaStatus({this.status});

  MahasiswaStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status
    };
  }
}