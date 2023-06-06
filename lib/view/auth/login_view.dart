import 'package:flutter/services.dart';
import 'package:presencee/theme/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/customers.dart';
import '../home/homePage.dart';
import 'dart:math' as math;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _secureText = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final emailController = TextEditingController();
  late final passController = TextEditingController();
  bool isButtonActive = false;
  late SharedPreferences login;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        isButtonActive =
            emailController.text.isNotEmpty && passController.text.isNotEmpty;
      });
    });
    passController.addListener(() {
      setState(() {
        isButtonActive =
            emailController.text.isNotEmpty && passController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void loginCheck() async {
    login = await SharedPreferences.getInstance();
    newUser = login.getBool('login') ?? true;
    if (newUser) {
      login.setBool('login', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 300,
                margin:
                    const EdgeInsets.symmetric(horizontal: 52, vertical: 40),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/logo_logins.png"),
                  ),
                ),
              ),
              Container(
                height: 330,
                margin: const EdgeInsets.symmetric(horizontal: 52),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email/NIM",
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "yourname@students.com",
                        hintStyle: TextStyle(
                          color: AppTheme.greyText,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      validator: (value) {
                        final emailRegex =
                            RegExp(r"^[a-zA-Z0-9_.+-]+@mail\.com$");
                        if (value == null || value.isEmpty) {
                          return 'Email must be filled';
                        } else if (value.length < 6) {
                          return 'Email must be at least 6 characters';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Password",
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: _secureText,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        LengthLimitingTextInputFormatter(20)
                      ],
                      decoration: InputDecoration(
                        suffixIcon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                            icon: Icon(
                              _secureText ? Icons.visibility_off_outlined : Icons.visibility,
                            ),
                          ),
                        ),
                        hintText: "input password",
                        hintStyle: const TextStyle(
                          color: AppTheme.greyText,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password must be filled';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 64),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryTheme_2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          disabledBackgroundColor: AppTheme.disabled,
                        ),
                        onPressed: isButtonActive
                            ? () {
                                if (formKey.currentState!.validate()) {
                                  loginCheck();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) => HomePage(),
                                      transitionsBuilder: (context, animation1,
                                          animation2, child) {
                                        return FadeTransition(
                                          opacity: animation1,
                                          child: child,
                                        );
                                      },
                                      transitionDuration: const Duration(milliseconds: 1200),
                                    ),
                                    (route) => false,
                                  );
                                }
                              }
                            : null,
                        child: Text(
                          "Login",
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 14,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => const CustomerService(),
                                transitionsBuilder:
                                    (context, animation1, animation2, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero,
                                    ).animate(animation1),
                                    child: child,
                                  );
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 490),
                              ));
                        },
                        child: const Text(
                          "Lupa Password?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: AppTheme.primaryTheme_2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
