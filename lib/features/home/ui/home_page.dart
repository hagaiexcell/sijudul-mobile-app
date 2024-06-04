import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/component/header_home.dart';
import 'package:flutter_project_skripsi/component/menu_bar.dart';
import 'package:flutter_project_skripsi/component/tag_status.dart';
import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileFetchEvent());

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoadedState) {
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
                  "Status Pengajuan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                const StatusHome(),
                const SizedBox(
                  height: 24,
                ),
                MenuHome(
                  icon: "lib/resources/images/ic-list.svg",
                  title: "Daftar Judul Mahasiswa",
                  onPressed: () {
                    Navigator.of(context).pushNamed('/list-judul');
                  },
                ),
                MenuHome(
                  icon: "lib/resources/images/ic-timbangan.svg",
                  title: "Cek Status Pengajuan",
                  onPressed: () {
                    Navigator.of(context).pushNamed('/detail-judul');
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
  const StatusHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [AppElevation.elevationPrimary]),
      child: Column(
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
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Judul",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Rancang Bangun Aplikasi SiJuDul Dengan Framework Flutter",
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
                const TagStatus(
                  status: "Approved",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
