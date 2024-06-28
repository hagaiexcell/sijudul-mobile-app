import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/component/header_home.dart';
import 'package:flutter_project_skripsi/component/menu_bar.dart';
import 'package:flutter_project_skripsi/component/tag_status.dart';
import 'package:flutter_project_skripsi/features/pengajuan/bloc/pengajuan_bloc.dart';
import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('userData');
    if (userDataJson != null) {
      final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
      return userData['id'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _getUserId().then((id) {
      // print("$id woy");
      if (id != null) {
        context.read<ProfileBloc>().add(ProfileFetchEvent(id: id));
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              // print("state $state");
              if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoadedState) {
                int userId = state.userData['id'];
                context
                    .read<PengajuanBloc>()
                    .add(MyPengajuanListEvent(id: userId, isInitial: true));
                return HeaderHome(
                  userData: state.userData,
                );
              } else if (state is ProfileErrorState) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Status Pengajuan Terkini",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<PengajuanBloc, PengajuanState>(
                  builder: (context, state) {
                    if (state is PengajuanLoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is PengajuanFetchingSuccessfulState) {
                      // print(state.listPengajuan);
                      return StatusHome(
                        pengajuan: state.listPengajuan,
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                MenuHome(
                  icon: "lib/resources/images/ic-list.svg",
                  title: "Daftar Judul Mahasiswa",
                  onPressed: () {
                    Navigator.of(context).pushNamed('/list-judul-all');
                  },
                ),
                MenuHome(
                  icon: "lib/resources/images/ic-timbangan.svg",
                  title: "Riwayat Pengajuan Saya",
                  onPressed: () {
                    Navigator.of(context).pushNamed('/list-judul-user');
                  },
                ),
                MenuHome(
                  icon: "lib/resources/images/ic-dosen.svg",
                  title: "Daftar Dosen Pembimbing 1",
                  onPressed: () {
                    Navigator.of(context).pushNamed('/list-dosen-1');
                  },
                ),
                MenuHome(
                  icon: "lib/resources/images/ic-dosen.svg",
                  title: "Daftar Dosen Pembimbing 2",
                  onPressed: () {
                    Navigator.of(context).pushNamed('/list-dosen-2');
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class StatusHome extends StatelessWidget {
  final List<dynamic> pengajuan;
  const StatusHome({super.key, required this.pengajuan});

  @override
  Widget build(BuildContext context) {
    int lengthPengajuan = pengajuan.length;
    // print(lengthPengajuan);

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [AppElevation.elevationPrimary]),
        child: pengajuan.isNotEmpty
            ? Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Judul",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lengthPengajuan > 0
                                    ? pengajuan[lengthPengajuan - 1].judul
                                    : "Anda Belum Mengajukan Judul Apa pun",
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        TagStatus(
                          status:
                              pengajuan[lengthPengajuan - 1].statusAccKaprodi ==
                                          "Pending" ||
                                      pengajuan[lengthPengajuan - 1]
                                              .statusAccKaprodi ==
                                          "Checking"
                                  ? "Pending"
                                  : pengajuan[lengthPengajuan - 1]
                                              .statusAccKaprodi ==
                                          "Approved"
                                      ? "Approved"
                                      : pengajuan[lengthPengajuan - 1]
                                                  .statusAccKaprodi ==
                                              "Rejected"
                                          ? "Rejected"
                                          : "",
                        )
                      ],
                    ),
                  )
                ],
              )
            : Text("Anda Belum Mengajukan Judul Apapun"));
  }
}
