import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/theme/constant.dart';

class CardMatkul extends StatelessWidget {
  final bool semester;
  const CardMatkul({
    super.key,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    return semester == false
        ? SizedBox(
    height: 164,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 5,
    itemBuilder: (context, index) {
    return Padding(
    padding: const EdgeInsets.only(left: 18),
    child: Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10)),
    child: InkWell(
    onTap: () {},
    child: SizedBox(
    width: 132,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    CircularPercentIndicator(
    radius: 40.0,
    animation: true,
    animationDuration: 1200,
    lineWidth: 7.0,
    percent: 0.8,
    // startAngle: 0.5,
    center: Container(
    width: 50,
    height: 50,
    decoration: const BoxDecoration(
    color: AppTheme.greenCard,
    shape: BoxShape.circle),
    child: Center(
    child: Text("MU",
    style: AppTextStyle.poppinsTextStyle(
    color: Colors.black,
    fontSize: 22,
    fontsWeight: FontWeight.w600)),
    ),
    ),
    backgroundColor: AppTheme.gray,
    progressColor: AppTheme.primaryTheme,
    ),
    const SizedBox(height: 10),
    Text(
    'Bhs Indonesia',
    style: AppTextStyle.poppinsTextStyle(
    color: Colors.black,
    fontSize: 12,
    fontsWeight: FontWeight.w600),
    )
    ],
    ),
    ),
    )),
    );
    },
    ),
    );
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CircularPercentIndicator(
                  radius: 40.0,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 7.0,
                  percent: 0.8,
                  // startAngle: 0.5,
                  center: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(225, 255, 230, 1),
                        shape: BoxShape.circle),
                    child: const Center(
                      child: Text(
                        "MU",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                    ),
                  ),
                  backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                  progressColor: primaryTheme,
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bhs Indonesia',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Siswandi',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/course_history');
                },
                // icon: Image.asset('lib/assets/icons/caret_right.png'),
                icon: const Icon(PhosphorIcons.caret_right,color: Color.fromRGBO(97, 97, 97, 1)),
              ),
            ],
          );

  }
}
