import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl/intl.dart';
import 'package:presencee/theme/constant.dart';
import 'package:provider/provider.dart';
import '../pages/history_view.dart';
import '../widgets/card_absensi.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isTodaySelected = true;    // Set initial selection state of "Hari ini" button
  bool isAllSelected = false;     // Set initial selection state of "Semua" button
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      print('ini jadwal');
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => JadwalPage()));
    } else if (_selectedIndex == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
    } else if (_selectedIndex == 2) {
      print('ini profile');
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _today(),
            Padding(
              // padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  _searchBar(),
                  SizedBox(height: 20),
                  _viewJadwal(),
                  SizedBox(height: 20),
                  _buildJadwalAbsensi(),
                ],
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(    // need rounded corner bottom navbar
          boxShadow: [
            BoxShadow(
              color: AppTheme.gray_2,
              blurRadius: 10,
            ),
          ],
        ),
        
        child: BottomNavigationBar(
          selectedItemColor: AppTheme.primaryTheme,
          selectedLabelStyle: AppTextStyle.poppinsTextStyle(
            color: AppTheme.primaryTheme,
            fontSize: 12,
            fontsWeight: FontWeight.w700,
          ),
          unselectedIconTheme: const IconThemeData(color: AppTheme.gray_2),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              // icon: Icon(Icons.menu_book_rounded),
              icon: Icon(PhosphorIcons.book_open_bold),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.clock_counter_clockwise_bold),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.user_bold),
              label: 'Profil',
            ),
          ],
        ),
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
        SizedBox(
          width: 5,
        ),
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

  return Container(
    // margin: const EdgeInsets.only(top: 12, left: 24, right: 24),
    child: TextField(
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
          decoration: BoxDecoration(
              // color: isSearch ? highlightSearch : Colors.transparent,      // change color when search are clicked
              border: Border(
            left: BorderSide(
              color: AppTheme.gray_2,
            ),
          )),
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
    ),
  );
}

Widget _today() {
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
        colors: [AppTheme.gradient_1, AppTheme.gradient_3],
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
          DateFormat('EEEE, d MMM yyyy', 'id').format(DateTime.now()),
          style: AppTextStyle.poppinsTextStyle(
            color: AppTheme.white,
            fontSize: 16,
          ),
        ),
        Text(
          DateFormat('HH.mm').format(DateTime.now()),
          style: AppTextStyle.poppinsTextStyle(
            color: AppTheme.white,
            fontSize: 48,
            fontsWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
