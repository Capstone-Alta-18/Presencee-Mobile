import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/bottomsheet_present.dart';
import 'package:presencee/view/widgets/card_presence.dart';
import 'package:presencee/view/widgets/today.dart';
import '../widgets/bottomsheet_presence.dart';

class PresenceView extends StatefulWidget {
  const PresenceView({super.key});

  @override
  State<PresenceView> createState() => _PresenceViewState();
}

class _PresenceViewState extends State<PresenceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const TodayWidgets(
            presensi: true,
            back: false,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.44, 
            child: const CardPresence()
          ),
          const BottomContainer(),    // butuh tambahan button di bawah
        ],
      ),
    );
  }
}
