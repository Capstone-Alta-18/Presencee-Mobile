import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/bottomsheet_fingerprint.dart';
import 'package:presencee/view/widgets/today.dart';

class FingerprintView extends StatefulWidget {
  final String namaMatkul;
  final String kodeKelas;
  final String namaDosen;
  final String date;
  final String namaMahasiswa;
  final String nim;
  final int idJadwal;
  const FingerprintView(
      {super.key,
      required this.idJadwal,
      required this.namaMatkul,
      required this.kodeKelas,
      required this.namaDosen,
      required this.date,
      required this.namaMahasiswa,
      required this.nim});

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
                          colors: [AppTheme.gradient_1, AppTheme.gradient_3],
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
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  PhosphorIcons.x,
                                  color: AppTheme.white,
                                  size: 28,
                                ),
                              ),
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
            FingerprintBottomsheet(
              idJadwal: widget.idJadwal,
              namaMatkul: widget.namaMatkul,
              namaDosen: widget.namaDosen,
              date: widget.date,
              kodeKelas: widget.kodeKelas,
              namaMahasiswa: widget.namaMahasiswa,
              nim: widget.nim,
            ),
          ],
        ),
      ),
    );
  }
}
