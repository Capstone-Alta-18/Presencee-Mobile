import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Header(title: "Profile Page", subtitle: "customization", back: false)
        ],
      )
    );
  }
}