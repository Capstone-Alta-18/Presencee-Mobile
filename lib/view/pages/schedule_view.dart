import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:presencee/view/widgets/today.dart';
import '../../theme/constant.dart';
import '../widgets/card_absensi.dart';
import 'mahasiswa_Viewmodel.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool isTodaySelected = true;    // Set initial selection state of "Hari ini" button
  bool isAllSelected = false;     // Set initial selection state of "Semua" button

  @override
  void initState() {
    super.initState();
    Provider.of<MahasiswaViewModel>(context, listen: false).getMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const TodayWidgets(presensi: false, back: false,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                _searchBar(),
                const SizedBox(height: 20),
                _viewJadwal(),
                const SizedBox(height: 20),
                _buildJadwalAbsensi(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalAbsensi() {
    // final mahasiswaList = Provider.of<MahasiswaViewModel>(context);

    if (isTodaySelected) {
      return CardAbsensi(
        Matkul: 'Bahasa Indonesia (MU22)',
        // Matkul: mahasiswaList.mahasiswas[0].status.toString(),
        hari: 'Senin',
        jam: '09.00 - 10.00',
      );
    } else if (isAllSelected) {
      return CardAbsensi(
        //filtering hari nya belum
        Matkul: 'Matematika (MTK22)',
        hari: 'Selasa',
        jam: '09.00 - 10.00',
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _viewJadwal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isTodaySelected = true;
              isAllSelected = false;
            });
          },
          child: Container(
            height: 22,
            width: 57,
            decoration: BoxDecoration(
              color: isTodaySelected ? AppTheme.primaryTheme_2 : AppTheme.gray_2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Hari ini',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            setState(() {
              isTodaySelected = false;
              isAllSelected = true;
            });
          },
          child: Container(
            height: 22,
            width: 57,
            decoration: BoxDecoration(
              color: isAllSelected ? AppTheme.primaryTheme_2 : AppTheme.gray_2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Semua',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _searchBar() {
  // bool isSearch = false;

  return TextField(
    inputFormatters: [
      LengthLimitingTextInputFormatter(15),
    ],
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      hintText: 'input search text...',
      hintStyle: const TextStyle(
        color: AppTheme.gray_2,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: AppTheme.gray_2,
        ),
      ),
      suffixIcon: Container(
        decoration: const BoxDecoration(
          // color: isSearch ? highlightSearch : Colors.transparent,      // change color when search are clicked
          border: Border(
            left: BorderSide(
              color: AppTheme.gray_2,
            ),
          ),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.search,
          ),
          onPressed: () {
            // isSearch = !isSearch;
          },
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: AppTheme.primaryTheme_2,
          width: 1,
        ),
      ),
    ),
    onChanged: (value) {
      // Implementasi logika pencarian di sini
    },
  );
}