// class UserModel {
//   int? id;
//   String? email;
//   String? name;
//   String? role;

//   UserModel({this.id, this.email, this.name, this.role});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     email = json['email'];
//     name = json['name'];
//     role = json['role'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['email'] = this.email;
//     data['name'] = this.name;
//     data['role'] = this.role;
//     return data;
//   }
// }

class User {
  final String message;
  final String token;

  User({required this.message, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      message: json['message'],
      token: json['token'],
    );
  }
}
