class FilterAbsen {
  int? id;
  int? userId;
  int? mahasiswaId;
  int? jadwalId;
  String? matakuliah;
  String? timeAttemp;
  String? status;
  String? location;
  String? image;
  bool? isKonfirmasi;

  FilterAbsen(
      {this.id,
      this.userId,
      this.mahasiswaId,
      this.jadwalId,
      this.matakuliah,
      this.timeAttemp,
      this.status,
      this.location,
      this.image,
      this.isKonfirmasi});

  factory FilterAbsen.fromJson(Map<String, dynamic> json) {
    return FilterAbsen(
      id: json['id'],
      userId: json['user_id'],
      mahasiswaId: json['mahasiswa_id'],
      jadwalId: json['jadwal_id'],
      matakuliah: json['matakuliah'],
      timeAttemp: json['time_attemp'],
      status: json['status'],
      location: json['location'],
      image: json['image'],
      isKonfirmasi: json['is_konfirmasi'],
    );
  }
}
