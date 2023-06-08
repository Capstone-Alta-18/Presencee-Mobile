import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/course_history_view.dart';
import 'package:provider/provider.dart';

import '../../provider/kehadiran_viewModel.dart';

class BottomSheetPresence extends StatefulWidget {
  const BottomSheetPresence({super.key});

  @override
  State<BottomSheetPresence> createState() => _BottomSheetPresenceState();
}

class _BottomSheetPresenceState extends State<BottomSheetPresence> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        height: _isExpanded == true
            ? MediaQuery.of(context).size.height / 1.6
            : MediaQuery.of(context).size.height / 3.8,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dy > 4) {
                  setState(() {
                    _isExpanded = false;
                  });
                } else if (details.delta.dy < -6) {
                  setState(() {
                    _isExpanded = true;
                  });
                }
              },
              child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: const BoxDecoration(
                    // color: AppTheme.gray,
                    color: Colors.transparent,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: 94,
                      height: 7,
                      decoration: BoxDecoration(
                        color: AppTheme.black_5,
                        borderRadius: BorderRadius.circular(19),
                      ),
                    ),
                  )),
            ),
            // const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 5 + 1,
                itemBuilder: (context, index) {
                  if (index < 5) {
                    return SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bahasa Indonesia (MU22)',
                                  style: AppTextStyle.poppinsTextStyle(
                                    color: AppTheme.black,
                                    fontsWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Masuk : 28 Februari',
                                  style: AppTextStyle.poppinsTextStyle(
                                    color: AppTheme.black_3,
                                    fontsWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 125,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryTheme_2,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Terkonfirmasi',
                                  style: AppTextStyle.poppinsTextStyle(
                                    color: AppTheme.white,
                                    fontsWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.primaryTheme_2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        onPressed: () {
                          var manager = Provider.of<KehadiranViewModel>(context);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var tween = Tween<double>(begin: 0.0, end: 1.0);
                                var curvedAnimation = CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.ease,
                                );
                                return FadeTransition(
                                  opacity: tween.animate(curvedAnimation),
                                  child: child,
                                );
                              },
                              pageBuilder: (context, animation, secondaryAnimation) => CourseHistory(manager: manager, selectedIndex: index),
                            ),
                          );
                        },
                        child: Text(
                          "Lihat Semua",
                          style: AppTextStyle.poppinsTextStyle(
                            fontsWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  if (index < 5) {
                    return const SizedBox(
                      height: 24,
                      child: Divider(
                        thickness: 0.8,
                        color: AppTheme.gray_2,
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
