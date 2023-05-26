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
                    // icon: Image.asset('lib/assets/icons/close.png'),
                    icon: Icon(PhosphorIcons.x,color: Colors.white,size: 30,),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 38),
                    child: Text(
                      'Riwayat Kehadiran',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 310,
            height: 32,
            child: TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(236, 173, 171, 1)),
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