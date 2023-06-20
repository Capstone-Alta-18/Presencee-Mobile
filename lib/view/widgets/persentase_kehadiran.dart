import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:presencee/view/widgets/State_Status_widget.dart';
import 'package:presencee/view_model/kehadiran_view_model.dart';
import 'package:presencee/theme/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PersentaseKehadiran extends StatefulWidget {
  final bool diagram;
  const PersentaseKehadiran({super.key, required this.diagram});

  @override
  State<PersentaseKehadiran> createState() => _PersentaseKehadiranState();
}

class _PersentaseKehadiranState extends State<PersentaseKehadiran> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<KehadiranViewModel>(context, listen: false).getKehadiranNew(idMhs: 0);
    });
  }


  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<KehadiranViewModel>(context);

    if (manager.state == DataState.initial) {
      return const LoadingMatkulCard();
    } else if (manager.state == DataState.loading) {
      return const LoadingMatkulCard();
    } else if (manager.state == DataState.error) {
      return const ErrorMatkulCards();
    }

    return widget.diagram == false
        ? CircularPercentIndicator(
            radius: 105.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 15.0,
            percent: manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Total"]).reduce((value, element) => (value + element)).toDouble() / 80,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${manager.kehadiranNew.meta!.toJson().values.toList().map((e) => e["Total"]).reduce((value, element) => (value + element)).toDouble() / 80 * 100} %",
                  // "62,5%",
                  style: AppTextStyle.poppinsTextStyle(
                    color: AppTheme.black,
                    fontSize: 28,
                    fontsWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 127,
                  height: 27,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppTheme.primaryTheme,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    "Minggu ke-10",
                    style: AppTextStyle.poppinsTextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontsWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: AppTheme.gray,
            progressColor: AppTheme.primaryTheme,
          )
        : CircularPercentIndicator(
            radius: 120.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 30.0,
            percent: 0.8,
            center: Text(
              "63,5%",
              style: AppTextStyle.poppinsTextStyle(
                color: AppTheme.black,
                fontSize: 40,
                fontsWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: AppTheme.gray,
            progressColor: AppTheme.primaryTheme,
          );
  }
}
