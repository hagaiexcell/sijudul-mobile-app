import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
// import 'resources/colors.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadiusDirectional.horizontal(
          start: Radius.circular(24.0),
          end: Radius.circular(24.0),
        ),
        image: DecorationImage(
            image: AssetImage("lib/resources/images/abstract.png"),
            fit: BoxFit.cover,
            opacity: 0.5),
      ),
      child: Wrap(runSpacing: 12, alignment: WrapAlignment.center, children: [
        Image.asset(
          "lib/resources/images/logo-upn-mini.png",
          width: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Marwahal Hagai Excellent",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18),
                ),
                Text(
                  "2010511072",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )
              ],
            ),
            ClipOval(
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(228, 228, 228, 1),
                    image: DecorationImage(
                        image: AssetImage(
                            "lib/resources/images/empty-profile.png"))),
              ),
            )
          ],
        )
      ]),
    );
  }
}
