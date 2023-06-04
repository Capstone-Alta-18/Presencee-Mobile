import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presencee/view/widgets/today.dart';
import '../../theme/constant.dart';
import '../widgets/card_absensi.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool isTodaySelected = true;    // Set initial selection state of "Hari ini" button
  bool isAllSelected = false;     // Set initial selection state of "Semua" button

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
            )
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalAbsensi() {
    if (isTodaySelected) {
      return CardAbsensi(
        //kalau datanya udah ada nanti pakai list view
        Matkul: 'Bahasa Indonesia (MU22)', //nanti diganti sesuai Data Base
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
      return SizedBox.shrink();
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
              color:
                  isTodaySelected ? AppTheme.primaryTheme_2 : AppTheme.gray_2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Hari ini',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.white,
                  fontSize: 12,
                )
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
              color:
                  isAllSelected ? AppTheme.primaryTheme_2 : AppTheme.gray_2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Semua',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.white,
                  fontSize: 12,
                )
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

// Widget _today() {
//   return Container(
//     height: 237,
//     width: double.maxFinite,
//     decoration: const BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: AppTheme.gray_2,
//           blurRadius: 5,
//           offset: Offset(0, 3),
//         ),
//       ],
//       gradient: LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [AppTheme.gradient_1, AppTheme.gradient_3],
//       ),
//       borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(40),
//         bottomRight: Radius.circular(40),
//       ),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           DateFormat('EEEE, d MMM yyyy', 'id').format(DateTime.now()),
//           style: AppTextStyle.poppinsTextStyle(
//             color: AppTheme.white,
//             fontSize: 16,
//           ),
//         ),
//         Text(
//           DateFormat('HH.mm').format(DateTime.now()),
//           style: AppTextStyle.poppinsTextStyle(
//             color: AppTheme.white,
//             fontSize: 48,
//             fontsWeight: FontWeight.w700,
//           ),
//         ),
//       ],
//     ),
//   );
// }