import 'package:flutter/material.dart';
import 'package:presencee/provider/kehadiran_viewModel.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/profile_view.dart';
import 'package:presencee/view/pages/schedule_view.dart';
import 'package:presencee/view/widgets/card_matkul.dart';
import 'package:presencee/view/widgets/header.dart';
import 'package:provider/provider.dart';
import 'course_history_view.dart';

import 'history_view.dart';

class SemesterHistory extends StatefulWidget {
  const SemesterHistory({super.key});

  @override
  State<SemesterHistory> createState() => _SemesterHistoryState();
}

class _SemesterHistoryState extends State<SemesterHistory> {
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
    final manager = Provider.of<KehadiranViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              title: 'Riwayat Kehadiran',
              subtitle: 'Semester 2022/2',
              back: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: manager.kehadiran.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor:
                                  AppTheme.primaryTheme.withOpacity(0.4),
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        CourseHistory(
                                      manager: manager,
                                      selectedIndex: index,
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 128,
                                child: CardMatkul(
                                  semester: true,
                                  selectedIndex: index,
                                  manager: manager,
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.gray_2,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppTheme.primaryTheme,
          selectedLabelStyle: TextStyle(
            color: AppTheme.primaryTheme,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          unselectedIconTheme: IconThemeData(color: AppTheme.gray_2),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.book_open_bold),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.clock_counter_clockwise_bold),
              label: 'Riwayat',
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
}
