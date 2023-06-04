import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/bottomsheet_presence.dart';
import 'package:presencee/view/widgets/card_presence.dart';
import 'package:presencee/view/widgets/today.dart';

class PresenceView extends StatefulWidget {
  const PresenceView({super.key});

  @override
  State<PresenceView> createState() => _PresenceViewState();
}

class _PresenceViewState extends State<PresenceView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            TodayWidgets(presensi: true, back: false,),
            CardPresence(),
            BottomSheetPresence(),
          ],
        ),
      ),
    );
  }
}
