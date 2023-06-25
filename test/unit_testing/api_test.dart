import 'package:presencee/model/API/dosen_api.dart';
import 'package:presencee/model/API/jadwal_api.dart';
import 'package:presencee/model/API/mahasiswa_api.dart';
import 'package:test/test.dart';
import 'package:presencee/model/API/user_api.dart';

void main() {
  
  group('API Testing', () {
    test('Login User API', () async {
      var users = await UserAPI().userLogin('test@gmail.com', '123456');
      expect(users, isNotNull);
      expect(users.message, 'success login');
    });

    test('Get Semua Jadwal API', () async {
      var jadwals = await JadwalApi.getPageJadwal(pages: 1, limits: 10);
      expect(jadwals, isNotNull);
      expect(jadwals.length, 10);

      // data dinamis, bisa bisa berubah
      expect(jadwals[0].name, 'Bahasa Indonesia');
      expect(jadwals[0].dosen?.name, 'M.Yazid');
      expect(jadwals[0].dosen?.phone, '08374863578');
    });

    test('Get Semua Mahasiswa API', () async {
      var siswa = await MahasiswaAPI.getMahasiswa();
      expect(siswa, isNotNull);
      // expect(siswa, isNull);     // if null bakal error
      expect(siswa.length, 41);     // default 37 mahasiswa kemungkinan akan nambah
    });

    test('Get single mahasiswa API', () async {
      var oneSiswa = await MahasiswaAPI.getOneMahasiswa(oneId: 35);
      expect(oneSiswa, isNotNull);
      expect(oneSiswa.name, 'Alexander New');
    });
    
  });
  
}