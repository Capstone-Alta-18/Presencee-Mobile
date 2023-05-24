import 'package:flutter/material.dart';

class RingkasanKehadiran extends StatelessWidget {
  const RingkasanKehadiran({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.only(top: 44, left: 24, right: 24),
    child: Column(
      children: [
        const Row(
          children: [
            Text(
              'Ringkasan kehadiran',
              style: TextStyle(
                color: Color.fromRGBO(36, 36, 36, 1),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 30,
              width: 112,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(254, 175, 164, 1)),
                ),
                onPressed: () {},
                child: const Text(
                  'Mingguan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 19),
      ],
    ),
  );
  }
}