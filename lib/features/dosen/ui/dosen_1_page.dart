// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/dosen/bloc/dosen1_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class Dosen1Page extends StatelessWidget {
  final String type;
  const Dosen1Page({
    Key? key,
    required this.type,
  }) : super(key: key);

  Future<Map<String, dynamic>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('userData');
    if (userDataJson != null) {
      final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
      return userData;
    }
    throw Exception('User data not found');
  }

  // Future<void> _launchWhatsApp(String phoneNumber) async {
  //   final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber');
  //   if (await canLaunch(whatsappUrl.toString())) {
  //     await launch(whatsappUrl.toString());
  //   } else {
  //     throw 'Could not launch $whatsappUrl';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
        title: type == "dosen1" ? "Dosen Pembimbing 1" : "Dosen Pembimbing 2",
        context: context,
      ),
      body: FutureBuilder(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final userData = snapshot.data!;
              final userId = userData['id'];
              final prodi = userData['prodi'];

              context
                  .read<Dosen1Bloc>()
                  .add(DosenInitialFetchEvent(type: type, prodi: prodi));
              return BlocConsumer<Dosen1Bloc, Dosen1State>(
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
                    context
                        .read<Dosen1Bloc>()
                        .add(DosenInitialFetchEvent(type: type, prodi: prodi));
                  } else if (state is DosenLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if ((type == "dosen1" &&
                          state is Dosen1FetchingSuccessfulState) ||
                      (type == "dosen2" &&
                          state is Dosen2FetchingSuccessfulState)) {
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
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
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                228, 228, 228, 1),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    listDosen[index].image),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            "(kuota : ${listDosen[index].kapasitas - listDosen[index].mahasiswaBimbingan.length})",
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
                              InkWell(
                                onTap: () {
                                  listDosen[index].noTelp == ""
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Message',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              content: const Text(
                                                  "Dosen Tidak Memiliki No Telpon"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primary)),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      : launchUrl(Uri.parse(
                                          'https://wa.me/${listDosen[index].noTelp}'));
                                },
                                child: SvgPicture.asset(
                                  "lib/resources/images/ic-envelope.svg",
                                  width: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center();
                },
              );
            } else {
              return const Center(child: Text('No data'));
            }
          }),
    );
  }
}
