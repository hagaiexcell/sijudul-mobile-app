// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/dosen/bloc/dosen1_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class Dosen1Page extends StatelessWidget {
  final String type;
  const Dosen1Page({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<Dosen1Bloc>().add(DosenInitialFetchEvent(type: type));
    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
        title: type == "dosen1" ? "Dosen Pembimbing 1" : "Dosen Pembimbing 2",
        context: context,
      ),
      body: BlocConsumer<Dosen1Bloc, Dosen1State>(
        listener: (context, state) {
          if (state is DosenFetchingErrorState) {
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
          if (state is DosenResetState) {
            context.read<Dosen1Bloc>().add(DosenInitialFetchEvent(type: type));
          } else if (state is DosenLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if ((type == "dosen1" &&
                  state is Dosen1FetchingSuccessfulState) ||
              (type == "dosen2" && state is Dosen2FetchingSuccessfulState)) {
            final listDosen = state is Dosen1FetchingSuccessfulState
                ? state.listDosen
                : (state as Dosen2FetchingSuccessfulState).listDosen;
            return ListView.builder(
              itemCount: listDosen.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                  '/detail-dosen',
                  arguments: listDosen[index].id,
                ),
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listDosen[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    listDosen[index].jabatan == ""
                                        ? "Dosen"
                                        : listDosen[index].jabatan,
                                    style: const TextStyle(
                                        color: AppColors.gray700),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "(kuota : ${listDosen[index].kapasitas})",
                                    style: const TextStyle(
                                        color: AppColors.primary),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    listDosen[index].prodi,
                                    style: const TextStyle(
                                        color: AppColors.gray700,
                                        fontWeight: FontWeight.w600),
                                  ),
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
          return const Center();
        },
      ),
    );
  }
}
