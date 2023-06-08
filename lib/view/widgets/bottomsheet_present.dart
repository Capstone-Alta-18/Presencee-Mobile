import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';

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
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
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
                margin: const EdgeInsets.only(top: 30),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  controller: scrollController,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bahasa Indonesia (MU22)',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Masuk : ${dayWeek + (index * 7)} Februari 2021",
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black_5,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 25,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryTheme_2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Terkonfirmasi',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}