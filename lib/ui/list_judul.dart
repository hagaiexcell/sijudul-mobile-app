import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListJudul extends StatelessWidget {
  ListJudul({Key? key}) : super(key: key);

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
        title: "Daftar Judul Mahasiswa",
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
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rancang Bangun Aplikasi SiJuDul Dengan Framework Flutter",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Marwahal Hagai Excellent - 2010511072",
                      style: TextStyle(color: AppColors.gray700),
                    )
                  ],
                ),
              ),
              SvgPicture.asset(
                "lib/resources/images/arrow-right.svg",
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
