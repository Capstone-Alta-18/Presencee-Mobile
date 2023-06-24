import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:presencee/view/widgets/State_Status_widget.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:presencee/model/jadwal_model.dart';
import 'package:presencee/view_model/jadwal_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:provider/provider.dart';
import 'package:presencee/view/widgets/today.dart';
import '../../theme/constant.dart';
// import '../widgets/alerted_attendance.dart';
import '../widgets/card_absensi.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool isTodaySelected =
      true; // Set initial selection state of "Hari ini" button
  bool isAllSelected = false; // Set initial selection state of "Semua" button
  StreamController<DateTime> timeController = StreamController<DateTime>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MahasiswaViewModel>(context, listen: false).getMahasiswa();
      Provider.of<JadwalViewModel>(context, listen: false).getJadwal(
        pages: 1,
        limits: 10,
      );
    });
    Timer.periodic(Duration(seconds: 1), (_) {
      timeController.add(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<DateTime>(
              stream: timeController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DateTime currentTime = snapshot.data!;
                  return TodayWidgets(
                    presensi: false,
                    back: false,
                    currentTime: currentTime,
                  );
                } else {
                  return Container(
                    height: 237,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.gray_2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppTheme.gradient_1, AppTheme.gradient_2],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading',
                          style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.white,
                              fontSize: 14,
                              fontsWeight: FontWeight.w400),
                        ),
                        Text(
                          'Loading',
                          style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.white,
                            fontSize: 45,
                            fontsWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
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
    final allJadwal = Provider.of<JadwalViewModel>(context);

    if (allJadwal.status == Status.initial) {
      return const Center();
    } else if (allJadwal.status == Status.loading) {
      return const Center();
    } else if (allJadwal.status == Status.error) {
      return const Center();
    }

    String getInitials(String name) {
      if (name.isEmpty) return '';

      final words = name.split(' ');
      final initials = words.map((word) => word[0].toUpperCase()).join('');

      return initials;
    }

    String getDayName(String dateString) {
      final dateTime = DateTime.parse(dateString);
      final dayName = DateFormat('EEEE').format(dateTime);
      return dayName;
    }

    String getTime(String dateString) {
      final dateTime = DateTime.parse(dateString);
      final time = DateFormat('HH:mm').format(dateTime);
      return time;
    }

    final fullName = allJadwal.jadwals[0].name!;
    final initials = getInitials(fullName);
    final dayName = getDayName(allJadwal.jadwals[0].jam!);
    final time = getTime(allJadwal.jadwals[0].jam!);

    if (isTodaySelected) {
      return CardAbsensi(
        matkul: fullName + '(' + initials + ')',
        dosen: allJadwal.jadwals[0].dosen!.name!,
        jam: "$dayName, $time",
      );
    } else if (isAllSelected) {
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: allJadwal.jadwals.length,
        itemBuilder: (context, index) {
          return CardAbsensi(
            matkul: allJadwal.jadwals[index].name!,
            dosen: allJadwal.jadwals[index].dosen!.name!,
            jam: allJadwal.jadwals[index].jam!,
          );
        },
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
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
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
