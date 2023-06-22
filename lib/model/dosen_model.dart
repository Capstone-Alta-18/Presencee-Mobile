class DosenModel {
  List<Dosens>? dosens;
  String? status;

  DosenModel({this.dosens, this.status});

  DosenModel.fromJson(Map<String, dynamic> json) {
    if (json['dosens'] != null) {
      dosens = <Dosens>[];
      json['dosens'].forEach((v) {
        dosens!.add(new Dosens.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dosens != null) {
      data['dosens'] = this.dosens!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Dosens {
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
