import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/pengajuan/bloc/pengajuan_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PengajuanListPage extends StatelessWidget {
  final String type;
  const PengajuanListPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  Future<int?> _getUserId() async {
    await Future.delayed(
        const Duration(milliseconds: 50)); // Add a 2-second delay
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      final Map<String, dynamic> userMap = jsonDecode(userData);
      return userMap['id'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (type == "all") {
      context
          .read<PengajuanBloc>()
          .add(const PengajuanInitialFetchEvent(isInitial: true));
      return BuildContent(
        type: type,
      );
    } else if (type == "user") {
      return FutureBuilder<int?>(
        future: _getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBarWidget.defaultAppBar(
                title: "Riwayat Pengajuan Saya",
                context: context,
              ),
              body: Container(
                color: Colors.white, // Set a background color
                child: const Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user ID found'));
          } else {
            final userId = snapshot.data!;
            context.read<PengajuanBloc>().add(
                PengajuanFetchAllByMahasiswaIdEvent(
                    id: userId, isInitial: true));
            return BuildContent(
              type: type,
            );
          }
        },
      );
    }

    return BuildContent(
      type: type,
    );
  }
}

class BuildContent extends StatelessWidget {
  final String type;
  final int? userId;
  const BuildContent({
    required this.type,
    this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
        title: type == "all" ? "Daftar Judul Mahasiswa" : "Riwayat Pengajuan Saya",
        context: context,
      ),
      body: BlocConsumer<PengajuanBloc, PengajuanState>(
        listener: (context, state) {
          if (state is PengajuanFetchingErrorState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is PengajuanResetState) {
            if (type == "all") {
              context
                  .read<PengajuanBloc>()
                  .add(const PengajuanInitialFetchEvent(isInitial: false));
            } else if (type == "user") {
              context.read<PengajuanBloc>().add(
                  PengajuanFetchAllByMahasiswaIdEvent(
                      id: userId, isInitial: false));
            }
            return const Center(child: CircularProgressIndicator());
          } else if (state is PengajuanLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PengajuanFetchingSuccessfulState) {
            return ListView.builder(
              itemCount: state.listPengajuan.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/detail-judul',
                    arguments: state.listPengajuan[index].id,
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [AppElevation.elevationPrimary],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.listPengajuan[index].judul,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${state.listPengajuan[index].mahasiswa.name} - ${state.listPengajuan[index].mahasiswa.nim}",
                              style: const TextStyle(color: AppColors.gray700),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${state.listPengajuan[index].mahasiswa.prodi} (${state.listPengajuan[index].mahasiswa.angkatan})",
                              style: const TextStyle(color: AppColors.gray700),
                            ),
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
          return Container();
        },
      ),
    );
  }
}
