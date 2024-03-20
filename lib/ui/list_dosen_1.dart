import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListDosen1 extends StatelessWidget {
  ListDosen1({super.key});

  final List<String> items = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
    'item6',
    'item4',
    'item5',
    'item6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
        title: "Dosen Pembimbing 1",
        context: context,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [AppElevation.elevationPrimary],
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nur Hafifah Matondang, S.Kom., M.M., M.T.I.",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "(kuota : 2)",
                            style: TextStyle(color: AppColors.primary),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              SvgPicture.asset(
                "lib/resources/images/ic-envelope.svg",
                width: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
