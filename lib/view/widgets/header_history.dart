import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/theme/constant.dart';

class HeaderHistory extends StatelessWidget {
  const HeaderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      color: AppTheme.primaryTheme,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(PhosphorIcons.x,color: AppTheme.white, size: 30,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38),
                    child: Text(
                      'Riwayat Kehadiran',
                      style: AppTextStyle.poppinsTextStyle(
                        color: AppTheme.white,
                        fontsWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 310,
            height: 32,
            child: TabBar(
              indicatorColor: AppTheme.white,
              labelStyle: AppTextStyle.poppinsTextStyle(
                color: AppTheme.white,
                fontsWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelStyle: AppTextStyle.poppinsTextStyle(
                color: const Color(0xFFECADAB),
                fontsWeight: FontWeight.w400,
                fontSize: 14,
              ),
              tabs: [
                Text("LIST"),
                Text("DIAGRAM"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}