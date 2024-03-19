import 'package:flutter/material.dart';

class AppBarWidget {
  static AppBar defaultAppBar(
      {Color? color,
      String? title,
      List<Widget>? actions,
      required BuildContext context,
      bool? showLeading}) {
    return AppBar(
      title: Text(
        title ?? '',
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0.2,
      leading: showLeading != null && showLeading
          ? InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            )
          : null, // If showLeading is false, leading widget will be null
    );
  }

  // AppBar transparent with just Back Button
}
