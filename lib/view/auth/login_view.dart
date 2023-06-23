import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:presencee/model/API/privates.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presencee/theme/constant.dart';
import '../../view_model/user_view_model.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../widgets/alerted_attendance.dart';

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
  FocusNode textSecondFocusNode = FocusNode();
  bool isFailedLogin = false;
  bool isButtonActive = false;
  bool isLoading = false;
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

  void signIn() async {
    setState(() {
      isLoading = true;
    });
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
    await Provider.of<UserViewModel>(context, listen: false)
        .userLogin(emailController.text, passController.text);
    if (mounted) {
      Navigator.pop(context);

      if (apiToken.isNotEmpty) {
        isLoading = false;
        if (mounted) {
          UserViewModel userViewModel =
              Provider.of<UserViewModel>(context, listen: false);
          await Provider.of<MahasiswaViewModel>(context, listen: false)
              .getOneMahasiswa(
                  oneId: userViewModel.user?.data?.mahasiswa?.id ?? 0);
          if (mounted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('//home', (route) => false);
            SnackbarAlertDialog().customDialogs(context,
                message: "Login Berhasil",
                icons: PhosphorIcons.check_circle_fill,
                iconColor: AppTheme.success,
                backgroundsColor: AppTheme.white,
                margin: const EdgeInsets.only(bottom: 0),
                durations: 1800);
          }
        }
      } else {
        setState(() {
          isFailedLogin = true;
          SnackbarAlertDialog().customDialogs(context,
              message: "Login gagal",
              icons: PhosphorIcons.x_circle_fill,
              backgroundsColor: AppTheme.error,
              iconColor: AppTheme.white,
              snacksbarsBehavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(bottom: 0),
              durations: 1200);
          isLoading = false;
        });
      }
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
                height: 380,
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
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "yourname@students.com",
                        hintStyle: const TextStyle(
                          color: AppTheme.greyText,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isFailedLogin == true
                                ? AppTheme.error
                                : AppTheme.greyText,
                          ),
                        ),
                        errorText: isFailedLogin == true
                            ? 'Email yang dimasukin salah'
                            : null,
                      ),
                      validator: (value) {
                        final emailRegex =
                            RegExp(r"^[a-zA-Z0-9_.+-]+@gmail\.com$");
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
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        LengthLimitingTextInputFormatter(20)
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password must be filled';
                        }
                        return null;
                      },
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                      onChanged: (value) {
                        setState(() {
                          isFailedLogin = false;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => showHide(),
                          icon: Icon(
                            _secureText
                                ? PhosphorIcons.eye_closed_bold
                                : PhosphorIcons.eye_bold,
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                            color: isFailedLogin == true
                                ? AppTheme.error
                                : AppTheme.greyText,
                          ),
                        ),
                        errorText: isFailedLogin == true
                            ? 'Kata sandi yang dimasukin salah'
                            : null,
                      ),
                    ),
                    const SizedBox(height: 64),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          backgroundColor: AppTheme.primaryTheme_2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          disabledBackgroundColor: AppTheme.disabled,
                        ),
                        onPressed: isButtonActive && !isLoading
                            ? () async {
                                if (formKey.currentState!.validate()) {
                                  signIn();
                                }
                              }
                            : null,
                        child: isLoading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SpinKitThreeBounce(
                                      color: AppTheme.white,
                                      size: 13.3,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "Masuk",
                                style: AppTextStyle.poppinsTextStyle(
                                  fontSize: 14,
                                  fontsWeight: FontWeight.w500,
                                  color: AppTheme.white,
                                ),
                              ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('//help'),
                        child: Text(
                          "Lupa Password?",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 14,
                            color: AppTheme.primaryTheme,
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
