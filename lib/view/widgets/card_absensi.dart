import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view_model/app_view_model.dart';
import 'package:provider/provider.dart';

class CardAbsensi extends StatelessWidget {
  bool isTodayPresent = true;
  final String matkul;
  final String kodeKelas;
  final String dosen;
  final String jam;
  final int idJadwal;
  CardAbsensi(
      {super.key,
      required this.matkul,
      required this.kodeKelas,
      required this.dosen,
      required this.jam,
      required this.idJadwal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
          splashColor: AppTheme.primaryTheme.withOpacity(0.2),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          onTap: () {
            Provider.of<AppViewModel>(context, listen: false).absenData({
              'namaMatkul': matkul,
              'namaDosen': dosen,
              'date': jam,
              'kodeKelas': kodeKelas,
              'idJadwal': idJadwal,
            }).then(
              (value) => Navigator.of(context).pushNamed('/schedule/presence'),
            );
          },
          title: Text('$matkul($kodeKelas)',
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontsWeight: FontWeight.w500,
                fontSize: 16,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                dosen,
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.gray_5,
                  fontsWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                jam,
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.gray_5,
                  fontsWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          trailing: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.005),
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<AppViewModel>(context, listen: false).absenData({
                  'namaMatkul': matkul,
                  'namaDosen': dosen,
                  'date': jam,
                  'kodeKelas': kodeKelas,
                  'idJadwal': idJadwal,
                }).then(
                  (value) =>
                      Navigator.of(context).pushNamed('/schedule/presence'),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isTodayPresent
                    ? AppTheme.primaryTheme
                    : AppTheme.primaryTheme_3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Presensi',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.white,
                  fontsWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          )),
    );
  }
}
