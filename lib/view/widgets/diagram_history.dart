import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/widgets/persentase_kehadiran.dart';
import 'package:presencee/view_model/absensi_view_model.dart';
import 'package:presencee/view_model/kehadiran_view_model.dart';
import 'package:provider/provider.dart';

class DiagramHistory extends StatelessWidget {
  // final KehadiranViewModel manager;
  // final int selectedIndex;
  final int idJadwal;
  DiagramHistory({super.key,required this.idJadwal});

  var afterTime = DateTime.utc(2023,06,18);
  var beforeTime = DateTime.now();
  
  List getWeeks(){
      var diff = beforeTime.difference(afterTime).inDays;
      var i = 0; 
      List<int> weeks = [];
      while(i<=112) { 
          if(i % 7 == 0){
            if(diff >= i){
              weeks.add(i);
              // return weeks;
            }
          }
          i++;
          // weeks.add(i);
      }
      // print(weeks);
      return weeks;
    }
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<KehadiranViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 27),
        Center(
          child: PersentaseKehadiran(
            diagram: true,
            selectedIndex: 0,
            idJadwal: idJadwal,
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
                      Text('${getWeeks().length} dari 16',
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
                            manager.kehadiran.meta!.hadir.toString(),
                            // '${manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Hadir"]).elementAt(selectedIndex)}',
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
                            manager.kehadiran.meta!.alpa.toString(),
                            // '${manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Alpa"]).elementAt(selectedIndex)}',
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
                            manager.kehadiran.meta!.sakit.toString(),
                            // '${manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Sakit"]).elementAt(selectedIndex)}',
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
                            manager.kehadiran.meta!.izin.toString(),
                            // '${manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Izin"]).elementAt(selectedIndex)}',
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
                            manager.kehadiran.meta!.dispensasi.toString(),
                            // '${manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Dispensasi"]).elementAt(selectedIndex)}',
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
