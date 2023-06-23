class DosenModel {
  List<Dosens>? dosens;
  String? status;

  DosenModel({this.dosens, this.status});

  DosenModel.fromJson(Map<String, dynamic> json) {
    if (json['dosens'] != null) {
      dosens = <Dosens>[];
      json['dosens'].forEach((v) {
        dosens!.add(Dosens.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dosens != null) {
      data['dosens'] = dosens!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Dosens {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;
  String? email;
  String? nip;
  String? phone;
  String? image;
  int? userId;

  Dosens(
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

  Dosens.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
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
