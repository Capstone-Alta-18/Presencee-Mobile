class Absensi {
  final String message;

  Absensi({required this.message});

  factory Absensi.fromJson(Map<String, dynamic> json) {
    return Absensi(
      message: json['message'],
    );
  }
}
