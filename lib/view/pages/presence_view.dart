import 'dart:async';

import 'package:flutter/material.dart';
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
                  return CircularProgressIndicator();
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
