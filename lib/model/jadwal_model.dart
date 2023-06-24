/* class JadwalPelajaran {
  List<Data>? data;

  JadwalPelajaran({this.data});

  JadwalPelajaran.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
} */

class Data {
  final int? id;
  final int? matakuliahId;
  final int? roomId;
  final String? sks;
  final String? jam;
  final String? name;
  final String? description;
  final int? userId;
  final int? dosenId;
  Dosen? dosen;

  Data(
      {this.id,
      this.matakuliahId,
      this.roomId,
      this.sks,
      this.jam,
      this.name,
      this.description,
      this.userId,
      this.dosenId,
      this.dosen});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      matakuliahId: json['matakuliah_id'],
      roomId: json['room_id'],
      sks: json['sks'],
      jam: json['jam_mulai'],
      name: json['name'],
      description: json['description'],
      userId: json['user_id'],
      dosenId: json['dosen_id'],
      dosen: json['dosen'] != null ? Dosen.fromJson(json['dosen']) : null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['matakuliah_id'] = this.matakuliahId;
    data['room_id'] = this.roomId;
    data['sks'] = this.sks;
    data['jam_mulai'] = this.jam;
    data['name'] = this.name;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['dosen_id'] = this.dosenId;
    if (this.dosen != null) {
      data['dosen'] = this.dosen!.toJson();
    }
    return data;
  }
}

class Dosen {
  int? iD;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? name;
  String? email;
  String? nip;
  String? phone;
  String? image;
  int? userId;

  Dosen(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.name,
      this.email,
      this.nip,
      this.phone,
      this.image,
      this.userId});

  Dosen.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    name = json['name'];
    email = json['email'];
    nip = json['nip'];
    phone = json['phone'];
    image = json['image'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['DeletedAt'] = this.deletedAt;
    data['name'] = this.name;
    data['email'] = this.email;
    data['nip'] = this.nip;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    return data;
  }
}
