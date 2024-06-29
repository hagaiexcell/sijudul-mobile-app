import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/dosen/bloc/dosen1_bloc.dart';
import 'package:flutter_project_skripsi/features/pengajuan/bloc/pengajuan_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DosenDetailPage extends StatelessWidget {
  const DosenDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    context.read<Dosen1Bloc>().add(DosenFetchByIdEvent(id: id));

    return Scaffold(
        appBar: AppBarWidget.defaultAppBar(
            title: "Detail Dosen Pembimbing",
            context: context,
            showLeading: true,
            onLeadingTap: () {
              context.read<Dosen1Bloc>().add(DosenResetStateEvent());

              Navigator.of(context).pop();
            }),
        body: BlocBuilder<Dosen1Bloc, Dosen1State>(
          builder: (context, state) {
            // print(state);
            if (state is DosenLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DosenDetailFetchingSuccessfulState) {
              // print(state.detail);
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [AppElevation.elevationPrimary],
                            color: Colors.white),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(228, 228, 228, 1),
                                image: DecorationImage(
                                    image: NetworkImage(state.detail.image),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Nama",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.name,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "NIDN",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.nidn,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.email,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "No Telepon",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.noTelp,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Gelar",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.gelar,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Jenjang Akademik",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.jenjangAkademik,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Prodi",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.prodi,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Jabatan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.jabatan,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Kepakaran",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    state.detail.kepakaran,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Sisa Kuota",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    (state.detail.kapasitas -
                                            state.detail.mahasiswaBimbingan
                                                .length)
                                        .toString(),
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButtonWithCustomStyle(
                        text: "Hubungi Dosen",
                        onPressed: () {
                          state.detail.noTelp == ""
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Message',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600)),
                                      content: const Text(
                                          "Dosen Tidak Memiliki No Telpon"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK',
                                              style: TextStyle(
                                                  color: AppColors.primary)),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : launchUrl(Uri.parse(
                                  'https://wa.me/${state.detail.noTelp}'));
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ));
  }
}
