import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title, subtitle;
  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 237,
    width: double.maxFinite,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFCD4F3E), Color(0xFFFE7968)],
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          Text(
            subtitle,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
  }
}