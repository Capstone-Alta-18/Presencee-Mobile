import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 40),
                  child: Image.asset(
                    "lib/assets/images/logo_logins.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.only(left: 84, bottom: 5),
                  child: Text(
                    "Email/NIM",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 84, right: 84),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      bottom: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      left: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      right: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "yourname@students.com",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            border: InputBorder.none),
                        validator: (emailValue) => emailValue!.isEmpty
                            ? 'Please enter your email'
                            : null),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 84, bottom: 5),
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 84, right: 84),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      bottom: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      left: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      right: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextFormField(
                              obscureText: _secureText,
                              decoration: const InputDecoration(
                                  hintText: "input password",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  border: InputBorder.none),
                              validator: (emailValue) => emailValue!.isEmpty
                                  ? 'Please enter your email'
                                  : null),
                        ),
                      ),
                      IconButton(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        iconSize: 20,
                        onPressed: showHide,
                        icon: Icon(
                          _secureText ? Icons.visibility_off : Icons.visibility,
                          color: const Color.fromRGBO(0, 0, 0, 0.45),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 67),
                GestureDetector(
                  child: Container(
                    height: 45,
                    margin: const EdgeInsets.symmetric(horizontal: 84),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: const Color.fromRGBO(254, 148, 134, 1)),
                    child: const Center(
                      child: Text(
                        key: Key('button_login'),
                        "Login",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 17),
                Center(
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Lupa Password?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color.fromRGBO(254, 184, 134, 1)),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
