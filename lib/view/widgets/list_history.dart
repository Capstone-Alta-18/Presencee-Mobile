import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:presencee/theme/constant.dart';
import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/attendance_subject_list.dart';

class ListHistory extends StatefulWidget {
  const ListHistory({super.key});

  @override
  State<ListHistory> createState() => _ListHistoryState();
}

final List<String> list = ['Terlama', 'Terbaru'];

class _ListHistoryState extends State<ListHistory> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 27),
          Container(
            width: double.infinity,
            height: 32,
            margin: const EdgeInsets.only(left: 24, right: 24),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.gray_2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: DropdownButton2(
              // https://stackoverflow.com/questions/70650773/flutter-i-want-to-show-dropdown-list-under-dropdown-flutter
              iconStyleData: const IconStyleData(
                icon: Icon(
                  PhosphorIcons.caret_down,
                  color: AppTheme.black_3,
                ),
              ),
              buttonStyleData: const ButtonStyleData(
                  /* decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryTheme),
                ), */
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16)),
              underline: Container(),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              hint: Text(
                'Pilih filter',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.gray,
                  fontsWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppTextStyle.poppinsTextStyle(
                      color: AppTheme.black,
                      fontsWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 39),
          const AttendanceSubsList(total: 17, mataKuliah: 'Bahasa Indonesia (MU22)', tanggalHadir: 'Masuk : 28 Februari', statusHadir: 'Terkonfirmasi')
        ],
      ),
    );
  }
}
