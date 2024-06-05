import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/pengajuan/bloc/pengajuan_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PengajuanListPage extends StatelessWidget {
  const PengajuanListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<PengajuanBloc>()
        .add(const PengajuanInitialFetchEvent(isInitial: true));

    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
        title: "Daftar Judul Mahasiswa",
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
          if (state is PengajuanInitial) {
            context
                .read<PengajuanBloc>()
                .add(const PengajuanInitialFetchEvent(isInitial: false));
            return const Center(child: CircularProgressIndicator());
          } else if (state is PengajuanLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PengajuanFetchingSuccessfulState) {
            return ListView.builder(
              itemCount: state.listPengajuan.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/detail-judul',
                      arguments: state.listPengajuan[index].id);
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
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${state.listPengajuan[index].mahasiswa.name} - ${state.listPengajuan[index].mahasiswa.nim}",
                              style: TextStyle(color: AppColors.gray700),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${state.listPengajuan[index].mahasiswa.prodi} (${state.listPengajuan[index].mahasiswa.angkatan})",
                              style: TextStyle(color: AppColors.gray700),
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
