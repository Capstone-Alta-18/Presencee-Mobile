class Jadwal {
  List<Data>? data;

  Jadwal({this.data});

  Jadwal.fromJson(Map<String, dynamic> json) {
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
}

class Data {
  int? id;
  int? matakuliahId;
  int? roomId;
  String? sks;
  String? jam;
  String? name;
  String? description;
  int? userId;
  int? dosenId;

  Data(
      {this.id,
      this.matakuliahId,
      this.roomId,
      this.sks,
      this.jam,
      this.name,
      this.description,
      this.userId,
      this.dosenId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matakuliahId = json['matakuliah_id'];
    roomId = json['room_id'];
    sks = json['sks'];
    jam = json['jam'];
    name = json['name'];
    description = json['description'];
    userId = json['user_id'];
    dosenId = json['dosen_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['matakuliah_id'] = this.matakuliahId;
    data['room_id'] = this.roomId;
    data['sks'] = this.sks;
    data['jam'] = this.jam;
    data['name'] = this.name;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['dosen_id'] = this.dosenId;
    return data;
  }
}
