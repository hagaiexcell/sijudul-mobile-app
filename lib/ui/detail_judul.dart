import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailJudul extends StatelessWidget {
  const DetailJudul({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarWidget.defaultAppBar(title: "Detail Judul", context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [AppElevation.elevationPrimary],
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.primary),
                          child: SvgPicture.asset(
                            "lib/resources/images/ic-list-white.svg",
                            width: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const Expanded(
                          child: Text(
                            "Rancang Bangun Aplikasi SiJuDul Dengan Framework Flutter",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color.fromARGB(176, 212, 212, 213)),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "lib/resources/images/ic-profile-grey.svg",
                          width: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Expanded(child: Text("Marwahal Hagai Excellent"))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "lib/resources/images/ic-stamp-grey.svg",
                          width: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text("2010511072")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "lib/resources/images/ic-location-grey.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Expanded(child: Text("UPN Veteran Jakarta"))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "lib/resources/images/ic-bars-grey.svg",
                          width: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Expanded(
                          child: Text(
                              "Bagaimana aplikasi pengajuan judul proposal skripsi berbasis mobile dapat meningkatkan efisiensi dalam proses pengajuan judul  di program studi Informatika UPN VeteranJakarta."),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "lib/resources/images/ic-timbangan-grey.svg",
                          width: 30,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text("Dr.Widya Cholil, S.Kom., M.I.T.")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "lib/resources/images/ic-timbangan-grey.svg",
                          width: 30,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text("Dr.Widya Cholil, S.Kom., M.I.T.")
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButtonWithCustomStyle(
                text: "APPROVED",
                type: "success",
                onPressed: () {},
                icon: "lib/resources/images/ic-checklist-white.svg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
