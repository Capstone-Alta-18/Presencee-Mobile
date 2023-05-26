import 'package:flutter/material.dart';
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
  bool isTodaySelected =
      true; // Set initial selection state of "Hari ini" button
  bool isAllSelected = false; // Set initial selection state of "Semua" button

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
      body: Column(
        children: [
          _today(),
          _searchBar(),
          _viewJadwal(),
          _buildJadwalAbsensi(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppTheme.primaryTheme_2,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
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
    return Padding(
      padding: const EdgeInsets.only(top: 12, right: 24, bottom: 24),
      child: Row(
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
                    isTodaySelected ? AppTheme.primaryTheme_2 : AppTheme.gray_5,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Hari ini',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: isTodaySelected ? Colors.white : Colors.black,
                  ),
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
                    isAllSelected ? AppTheme.primaryTheme_2 : AppTheme.gray_5,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Semua',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: isAllSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _searchBar() {
  // bool isSearch = false;

  return Container(
    margin: const EdgeInsets.only(top: 12, left: 24, right: 24),
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
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFCD4F3E), AppTheme.primaryTheme],
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('EEEE, d MMM yyyy').format(DateTime.now()),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
          // const SizedBox(height: 10),
          Text(
            DateFormat('HH.mm').format(DateTime.now()),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 45,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
