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
  final DraggableScrollableController _controller = DraggableScrollableController();
  final minSize = 0.25;
  final maxSize = 0.55;
  double blur = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        blur = (_controller.size >= 0.55) ? 0.5 : (_controller.size - 0.25) * 2;
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: minSize,
      controller: _controller,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: true,
      builder: (context, scrollController) => BackdropFilter(
        filter: ColorFilter.mode(AppTheme.primaryTheme.withOpacity(blur), BlendMode.srcOver),
        // filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
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
                  total: 12,
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