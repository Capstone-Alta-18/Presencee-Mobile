import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter/material.dart';
import '../../theme/constant.dart';
import 'maintenance_view.dart';

class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIcons.x, color: AppTheme.primaryTheme),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: AppTheme.primaryTheme),
        elevation: 0,
        backgroundColor: AppTheme.gray,
        title: Text(
          'Pusat Bantuan',
          style: AppTextStyle.poppinsTextStyle(
            fontsWeight: FontWeight.w500, 
            color: AppTheme.primaryTheme,
          ),
        ),
      ),
      body: const MaintenancePage(),
    );
  }
}