import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:presencee/provider/user_ViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presencee/theme/constant.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool isLoading = true;
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
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await Provider.of<UserViewModel>(context, listen: false)
        .userLogin(emailController.text, passController.text);
    if (mounted) {
      Navigator.pop(context);
      UserViewModel userViewModel =
          Provider.of<UserViewModel>(context, listen: false);
      if (userViewModel.user != null) {
        debugPrint(userViewModel.user?.message);
        debugPrint(userViewModel.user?.token);
        successMessage();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        setState(() {
          isFailedLogin = true;
          failedMessage();
        });
      }
    }
  }

  void successMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 1200),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.check,
              color: AppTheme.white,
            ),
            SizedBox(width: 10),
            Text(
              'Login success',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  void failedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 1200),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIcons.x_circle_fill,
              color: AppTheme.white,
            ),
            SizedBox(width: 10),
            Text(
              'Login gagal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.error,
      ),
    );
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
                        // final emailRegex =
                        // RegExp(r"^[a-zA-Z0-9_.+-]+@mail\.com$");
                        if (value == null || value.isEmpty) {
                          return 'Email must be filled';
                        } else if (value.length < 6) {
                          return 'Email must be at least 6 characters';
                          // } else if (!emailRegex.hasMatch(value)) {
                          // return 'Invalid email format';
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
                        // 2 opsi icon password
                        /* suffixIcon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: IconButton(
                            onPressed: () => showHide(),
                            icon: Icon(
                              _secureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                            ),
                          ),
                        ), */
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
                          backgroundColor: AppTheme.primaryTheme_2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          disabledBackgroundColor: AppTheme.disabled,
                        ),
                        onPressed: isButtonActive
                            ? () async {
                                if (formKey.currentState!.validate()) {
                                  signIn();
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
                        onPressed: () =>
                            Navigator.of(context).pushNamed('//help'),
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
