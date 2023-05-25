import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presencee/theme/constant.dart';
import 'package:provider/provider.dart';

import '../pages/history_view.dart';

class BottomNavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationProvider>(
      create: (context) => BottomNavigationProvider(),
      child: Scaffold(
        body: Column(
          children: [
            _today(),
            _searchBar(),
            Expanded(
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
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Consumer<BottomNavigationProvider>(
        builder: (context, provider, _) {
          return BottomNavigationBar(
            elevation: 15,
            backgroundColor: Colors.white,
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
                label: 'Profil',
              ),
            ],
            currentIndex: provider.selectedIndex,
            selectedItemColor: AppTheme.primaryTheme,
            selectedLabelStyle: AppTextStyle.poppinsTextStyle(
              color: AppTheme.primaryTheme,
              fontSize: 12,
              fontsWeight: FontWeight.w700,
            ),
            unselectedIconTheme: const IconThemeData(
              color: AppTheme.gray_2,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              provider.setIndex(index);
            },
          );
        },
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
            )
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
            DateFormat('EEEE, d MMM yyyy', 'id').format(DateTime.now()),
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
