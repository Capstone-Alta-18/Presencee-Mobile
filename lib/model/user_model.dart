import 'mahasiswa_model.dart';

class User {
  Data? data;
  String? message;
  String? token;

  User({this.data, this.message, this.token});

  User.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? name;
  String? role;
  Mahasiswas? mahasiswa;

  Data({this.id, this.email, this.name, this.role, this.mahasiswa});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    mahasiswa = json['mahasiswa'] != null
        ? Mahasiswas.fromJson(json['mahasiswa'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['role'] = role;
    if (mahasiswa != null) {
      data['mahasiswa'] = mahasiswa!.toJson();
    }
    return data;
  }
}
