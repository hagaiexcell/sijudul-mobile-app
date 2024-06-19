import 'package:flutter/material.dart';

class AppBarWidget {
  static AppBar defaultAppBar({
    Color? color,
    String? title,
    List<Widget>? actions,
    required BuildContext context,
    VoidCallback? onLeadingTap,
    bool? showLeading,
    VoidCallback? onSearchTap,
  }) {
    return AppBar(
      title: Text(
        title ?? '',
        style: const TextStyle(color: Colors.black),
      ),
      actions: actions ??
          (onSearchTap != null
              ? [
                  IconButton(
                    icon: const Icon(Icons.search_rounded, color: Colors.black),
                    onPressed: onSearchTap,
                  ),
                ]
              : null),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0.2,
      leading: showLeading != null && showLeading
          ? InkWell(
              onTap: onLeadingTap ??
                  () {
                    Navigator.of(context).pop();
                  },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            )
          : null,
    );
  }
}
