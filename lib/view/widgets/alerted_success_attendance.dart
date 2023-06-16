import 'package:flutter/material.dart';

class SnackbarAlertDialog {

  void customDialogs(BuildContext context, 
    {required String message,
      required IconData icons,
      required Color iconColor, 
      required Color backgroundsColor,
      required int durations,
    }) 
    {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: iconColor,
              size: 26,
            ),
            const SizedBox(width: 5),
            Text(
              message,
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: durations),
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.2, left: 20, right: 20),
        backgroundColor: backgroundsColor,
        behavior: SnackBarBehavior.floating,
        /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), */
      ),
    );
  }
}