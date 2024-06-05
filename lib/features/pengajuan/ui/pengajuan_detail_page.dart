import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/pengajuan/bloc/pengajuan_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanDetailPage extends StatelessWidget {
  const PengajuanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    context.read<PengajuanBloc>().add(PengajuanFetchByIdEvent(id: id));

    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
          title: "Detail Judul",
          context: context,
          showLeading: true,
          onLeadingTap: () {
            print('Leading icon tapped!');
            context.read<PengajuanBloc>().add(PengajuanInitialFetchEvent());

            Navigator.of(context).pop();
          }),
      body: BlocBuilder<PengajuanBloc, PengajuanState>(
        builder: (context, state) {
          if (state is PengajuanLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PengajuanDetailFetchingSuccessfulState) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              Expanded(
                                child: Text(
                                  state.pengajuanDetail.judul,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
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
                              Expanded(
                                  child: Text(
                                      state.pengajuanDetail.mahasiswa.name))
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
                              Text(state.pengajuanDetail.mahasiswa.nim)
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
                              Expanded(
                                  child: Text(
                                      state.pengajuanDetail.tempatPenelitian))
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
                              Expanded(
                                child:
                                    Text(state.pengajuanDetail.rumusanMasalah),
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
                              Text(state.pengajuanDetail.dospem1.name)
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
                              Text(state.pengajuanDetail.dospem2.name)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButtonWithCustomStyle(
                      text: state.pengajuanDetail.status == "Checking"
                          ? "PENDING"
                          : state.pengajuanDetail.status == "Approved"
                              ? "APPROVED"
                              : state.pengajuanDetail.status == "Rejected"
                                  ? "REJECTED"
                                  : "",
                      type: state.pengajuanDetail.status == "Checking"
                          ? "pending"
                          : state.pengajuanDetail.status == "Approved"
                              ? "success"
                              : state.pengajuanDetail.status == "Rejected"
                                  ? "danger"
                                  : "",
                      onPressed: () {},
                      icon: "lib/resources/images/ic-checklist-white.svg",
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [AppElevation.elevationPrimary],
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Catatan",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(state.pengajuanDetail.notes == ""
                              ? "-"
                              : state.pengajuanDetail.notes)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
