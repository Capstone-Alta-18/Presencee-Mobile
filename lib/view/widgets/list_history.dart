import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../theme/constant.dart';

class ListHistory extends StatefulWidget {
  const ListHistory({super.key});

  @override
  State<ListHistory> createState() => _ListHistoryState();
}

List<String> list = <String>['Terlama', 'Terbaru'];

class _ListHistoryState extends State<ListHistory> {
  String dropdownValue = list.first;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 27),
        Container(
          width: double.infinity,
          height: 32,
          margin: const EdgeInsets.only(left: 24, right: 24),
          decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(217, 217, 217, 1)),
              borderRadius: BorderRadius.circular(2)),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(
                  PhosphorIcons.caret_down,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
                hint: Text(
                  'Pilih filter',
                  style: AppTextStyle.poppinsTextStyle(
                    color: AppTheme.black_3,
                    fontsWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                value: dropdownValue,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 39),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bahasa Indonesia (MU22)',
                      style: AppTextStyle.poppinsTextStyle(
                        color: AppTheme.black,
                        fontsWeight: FontWeight.w600,
                        fontSize: 14,
                      )
                    ),
                    Text(
                      'Masuk : 28 Februari',
                      style: AppTextStyle.poppinsTextStyle(
                        color: AppTheme.black_3,
                        fontsWeight: FontWeight.w400,
                        fontSize: 12,
                      )
                    )
                  ],
                ),
                Container(
                  height: 30,
                  width: 125,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(254, 148, 134, 1),
                    borderRadius: BorderRadius.circular(10),
                    ),
                  child: Center(
                    child: Text(
                      'Terkonfirmasi',
                      style: AppTextStyle.poppinsTextStyle(
                        color: Colors.white,
                        fontsWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
