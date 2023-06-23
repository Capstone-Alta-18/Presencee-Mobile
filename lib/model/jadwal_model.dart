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
  final String? jamMulai;
  final String? jamSelesai;
  final String? name;
  final String? description;
  final int? userId;
  final int? dosenId;
  Dosen? dosen;
  Room? room;

  Data(
      {this.id,
      this.matakuliahId,
      this.roomId,
      this.sks,
      this.jamMulai,
      this.jamSelesai,
      this.name,
      this.description,
      this.userId,
      this.dosenId,
      this.dosen,
      this.room});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json['id'],
        matakuliahId: json['matakuliah_id'],
        roomId: json['room_id'],
        sks: json['sks'],
        jamMulai: json['jam_mulai'],
        jamSelesai: json['jam_selesai'],
        name: json['name'],
        description: json['description'],
        userId: json['user_id'],
        dosenId: json['dosen_id'],
        dosen: json['dosen'] != null ? Dosen.fromJson(json['dosen']) : null,
        room: json['room'] != null ? Room.fromJson(json['room']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['matakuliah_id'] = matakuliahId;
    data['room_id'] = roomId;
    data['sks'] = sks;
    data['jam_mulai'] = jamMulai;
    data['jam_selesai'] = jamSelesai;
    data['name'] = name;
    data['description'] = description;
    data['user_id'] = userId;
    data['dosen_id'] = dosenId;
    if (dosen != null) {
      data['dosen'] = dosen!.toJson();
    }
    if (room != null) {
      data['room'] = room!.toJson();
    }
    return data;
  }
}

class Dosen {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;
  String? email;
  String? nip;
  String? phone;
  String? image;
  int? userId;

  Dosen(
      {this.id,
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
    id = json['ID'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['name'] = name;
    data['email'] = email;
    data['nip'] = nip;
    data['phone'] = phone;
    data['image'] = image;
    data['user_id'] = userId;
    return data;
  }
}

class Room {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;
  String? location;
  String? code;

  Room(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.name,
      this.location,
      this.code});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    name = json['name'];
    location = json['location'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['name'] = name;
    data['location'] = location;
    data['code'] = code;
    return data;
  }
}
