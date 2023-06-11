import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presencee/theme/constant.dart';

class CustomerService extends StatelessWidget {
  const CustomerService({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.gray,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppTheme.primaryTheme,
            ),
          ),
          title: Text(
            'Lupa Password',
            style: AppTextStyle.poppinsTextStyle(
              color: AppTheme.primaryTheme,
              fontSize: 20,
              // fontsWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Flexible(
              flex: 3,
              child: Lottie.asset(
                'lib/assets/animation/help_center.json',
                width: double.infinity,
                height: 512,
              ),
              /* child: Image.asset(
                'lib/assets/images/customers.png',
                width: double.infinity,
                height: 259,
              ) */
            ),
            const SizedBox(
              height: 30,
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Text(
                      'Lupa Password?',
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 20,
                        fontsWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ), */
                    Text(
                      'Silahkan menghubungi CS Kampus',
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                        fontsWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF69B95C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              child: Text(
                                'WhatsApp',
                                style: AppTextStyle.poppinsTextStyle(
                                  fontSize: 14,
                                  fontsWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5C7BB9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              child: Text(
                                'Telegram',
                                style: AppTextStyle.poppinsTextStyle(
                                  fontSize: 14,
                                  fontsWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              )
            ),
          ],
        )
      ),
    );
  }
}