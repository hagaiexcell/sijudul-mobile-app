import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppColors {
  static const primary = Color(0XFFFFD600);
  static const success = Color(0XFF28C76F);
  static const danger = Color(0XFFEA5455);
  static const secondary = Color(0XFFA8AAAE);
  static const textColour10 = Color(0xFFE7E7E7);
  static const gray700 = Color.fromRGBO(75, 70, 92, 0.7);
  static const textColour90 = Color(0xFF252525);
}

class AppElevation {
  static BoxShadow elevationPrimary = const BoxShadow(
    color: Color.fromARGB(70, 150, 150, 150),
    spreadRadius: 0,
    blurRadius: 10,
    offset: Offset(0, 2),
  );
}

class ElevatedButtonWithCustomStyle extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final String? icon;
  final String? type;

  const ElevatedButtonWithCustomStyle(
      {required this.text,
      required this.onPressed,
      this.style,
      this.icon,
      this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: type == "success"
              ? AppColors.success
              : type == "danger"
                  ? AppColors.danger
                  : AppColors.primary,
          elevation: 0, // Hilangkan elevasi bawaan dari ElevatedButton
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Bentuk tepi tombol
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Padding dalam tombol
          shadowColor: Colors
              .transparent, // Hilangkan bayangan bawaan dari ElevatedButton
        ),
        child: icon != null
            ? Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      icon!,
                      width: 24,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
