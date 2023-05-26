import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

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
        const SizedBox(height: 37),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 76),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bahasa Indonesia (MU)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color.fromRGBO(36, 36, 36, 1),
                ),
              ),
              Text(
                'Siswandi',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ],
          ),
        ),
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
                // icon: Image.asset('lib/assets/icons/caret_down.png'),
                icon: const Icon(
                  PhosphorIcons.caret_down,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
                hint: const Text(
                  'Pilih filter',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bahasa Indonesia (MU22)',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(36, 36, 36, 1),
                      ),
                    ),
                    Text(
                      'Masuk : 28 Februari',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color.fromRGBO(97, 97, 97, 1),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 30,
                  width: 125,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(254, 148, 134, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      'Terkonfirmasi',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white),
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
