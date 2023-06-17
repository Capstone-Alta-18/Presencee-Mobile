import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/bottomsheet_present.dart';
import 'package:presencee/view/widgets/card_presence.dart';
import 'package:presencee/view/widgets/today.dart';

class PresenceView extends StatefulWidget {
  const PresenceView({super.key});

  @override
  State<PresenceView> createState() => _PresenceViewState();
}

class _PresenceViewState extends State<PresenceView> {
  StreamController<DateTime> timeController = StreamController<DateTime>();
  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 1), (_) {
      timeController.add(DateTime.now());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          StreamBuilder<DateTime>(
              stream: timeController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DateTime currentTime = snapshot.data!;
                  return TodayWidgets(
                    presensi: true,
                    back: false,
                    currentTime: currentTime,
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
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
                      children: [
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                PhosphorIcons.arrow_left,
                                color: AppTheme.white,
                                size: 28,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 27),
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
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.44,
              child: const CardPresence()),
          const BottomContainer(), // butuh tambahan button di bawah
        ],
      ),
    );
  }
}
