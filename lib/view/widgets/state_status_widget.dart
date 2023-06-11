import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:presencee/theme/constant.dart';
import 'package:shimmer/shimmer.dart';

class LoadingMatkulCard extends StatelessWidget {
  const LoadingMatkulCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 164,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Card(
              elevation: 2,
              color: AppTheme.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  width: 132,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpinKitRipple(
                        color: AppTheme.primaryTheme,
                        size: 90.0,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 100,
                        child: Shimmer.fromColors(
                          baseColor: AppTheme.gray,
                          highlightColor: AppTheme.gray_2,
                          child: Container(
                            height: 10,
                            color: AppTheme.gray,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ErrorMatkulCards extends StatelessWidget {
  const ErrorMatkulCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ProfileError extends StatelessWidget {
  const ProfileError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: AppTextStyle.poppinsTextStyle(
            fontsWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'lib/assets/animation/Disconnect.json',
              width: 360,
            ),
            Text(
              'Terjadi kesalahan',
              style: AppTextStyle.poppinsTextStyle(
                fontsWeight: FontWeight.w600,
                fontSize: 22,
                color: AppTheme.error,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Silahkan coba lagi',
              style: AppTextStyle.poppinsTextStyle(
                fontsWeight: FontWeight.w400,
                fontSize: 16,
                color: AppTheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilesLoading extends StatelessWidget {
  const ProfilesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: AppTextStyle.poppinsTextStyle(
            fontsWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: SpinKitCircle(
          color: AppTheme.primaryTheme,
          size: 90.0,
        ),
      ),
    );
  }
}