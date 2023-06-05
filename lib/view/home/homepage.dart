import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presencee/theme/constant.dart';
import 'package:flutter/material.dart';
import 'package:presencee/view/pages/profile_view.dart';
import '../pages/schedule_view.dart';
import '../pages/history_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const SchedulePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              // icon: Icon(PhosphorIcons.book_open_bold),
              icon: SvgPicture.asset('lib/assets/icons/book-open-text-bold.svg', height: 24, color: AppTheme.gray_2),
              activeIcon: SvgPicture.asset('lib/assets/icons/book-open-text-bold.svg', height: 24, color: AppTheme.primaryTheme),
              label: 'Jadwal',
            ),
            const BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.clock_counter_clockwise_bold),
              label: 'Riwayat',
            ),
            const BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.user_bold),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}