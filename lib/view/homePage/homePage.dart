import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isTodaySelected =
      true; // Set initial selection state of "Hari ini" button
  bool isAllSelected = false; // Set initial selection state of "Semua" button

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationProvider>(
      create: (context) => BottomNavigationProvider(),
      child: Scaffold(
        body: Column(
          children: [
            _today(),
            _searchBar(),
            _viewJadwal(),
            _bottomNavigator(),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
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
                color: isTodaySelected ? Color(0xFFFE9486) : Color(0xFFD1D1D1),
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
                color: isAllSelected ? Color(0xFFFE9486) : Color(0xFFD1D1D1),
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

  _bottomNavigator() {
    return Expanded(
      child: Consumer<BottomNavigationProvider>(
        builder: (context, provider, _) {
          if (provider.selectedIndex == 0) {
            print('ini jadwal');
            // return JadwalPage();
          } else if (provider.selectedIndex == 1) {
            print('ini history');
            // return HistoryPage();
          } else if (provider.selectedIndex == 2) {
            print('ini profile');
            // return ProfilePage();
          }
          return Container();
        },
      ),
    );
  }

  _searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 24, right: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD9D9D9)),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          suffixIcon: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: const Icon(Icons.search),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
          colors: [Color(0xFFCD4F3E), Color(0xFFFE7968)],
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
            const SizedBox(height: 10),
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
}

class BottomNavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
      builder: (context, provider, _) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
          currentIndex: provider.selectedIndex,
          selectedItemColor: const Color(0xFFFE7968),
          onTap: (index) {
            provider.setIndex(index);
          },
        );
      },
    );
  }
}
