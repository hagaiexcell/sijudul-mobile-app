import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class MenuHome extends StatelessWidget {
  const MenuHome(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  final String icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            boxShadow: [AppElevation.elevationPrimary],
            color: Colors.white,
            borderRadius: BorderRadius.circular(34)),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
