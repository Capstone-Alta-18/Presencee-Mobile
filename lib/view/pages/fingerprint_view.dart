import 'dart:async';

import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/bottomsheet_fingerprint.dart';
import 'package:presencee/view/widgets/today.dart';

class FingerprintView extends StatefulWidget {
  const FingerprintView({super.key});

  @override
  State<FingerprintView> createState() => _FingerprintViewState();
}

class _FingerprintViewState extends State<FingerprintView> {
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
      body: SingleChildScrollView(
        child: Stack(
          // alignment: Alignment.center,
          children: [
            StreamBuilder<DateTime>(
                stream: timeController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DateTime currentTime = snapshot.data!;
                    return TodayWidgets(
                      presensi: true,
                      back: true,
                      currentTime: currentTime,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            FingerprintBottomsheet(),
          ],
        ),
      ),
    );
  }
}
