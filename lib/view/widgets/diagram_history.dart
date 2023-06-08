import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/persentase_kehadiran.dart';

class DiagramHistory extends StatelessWidget {
  const DiagramHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 27),
        const Center(
          child: PersentaseKehadiran(
            diagram: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 33, right: 24, left: 24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: AppTheme.primaryTheme_5,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('10 dari 16',
                          style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.black,
                            fontsWeight: FontWeight.w600,
                            fontSize: 20,
                          )),
                      Text('pertemuan',
                          style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.black,
                            fontsWeight: FontWeight.w600,
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  color: AppTheme.gray,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12, left: 24, right: 24, bottom: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hadir',
                              style: AppTextStyle.poppinsTextStyle(
                                  color: AppTheme.black,
                                  fontsWeight: FontWeight.w400,
                                  fontSize: 16)),
                          Text(
                            '9',
                            style: AppTextStyle.poppinsTextStyle(
                                color: AppTheme.black,
                                fontsWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Alpa',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontsWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '0',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontsWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sakit',
                            style: AppTextStyle.poppinsTextStyle(
                                color: AppTheme.black,
                                fontsWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          Text(
                            '1',
                            style: AppTextStyle.poppinsTextStyle(
                                color: AppTheme.black,
                                fontsWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Izin',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontsWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '0',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontsWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dispensasi',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontsWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '0',
                            style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.black,
                              fontsWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
