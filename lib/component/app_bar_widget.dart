import 'package:flutter/material.dart';
import '/resources/resources.dart';

class AppBarWidget {
  static AppBar defaultAppBar({
    Color? color,
    String? title,
    List<Widget>? actions,
    required BuildContext context,
  }) {
    return AppBar(
      title: Text(
        title ?? '',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0.2,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        ),
      ),
    );
  }

  // AppBar transparent with just Back Button
}
