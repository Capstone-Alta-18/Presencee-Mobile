import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/attendance_subject_list.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer({super.key});

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  bool isExpand = false;
  int dayWeek = 2;
  
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 0.55,
      builder: (context, scrollController) => BackdropFilter(
        filter: ColorFilter.mode(AppTheme.primaryTheme.withOpacity(0.0), BlendMode.srcOver),
        child: Container(
          decoration: const BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 7,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 150),
                  decoration: BoxDecoration(
                    color: AppTheme.black_5,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 36),
                child: AttendanceSubsList(
                  total: 17,
                  mataKuliah: 'Bahasa Indonesia (MU22)', 
                  tanggalHadir: "Masuk : $dayWeek Februari 2021", 
                  statusHadir: "Terkonfirmasi", 
                  scrollControllers: scrollController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}