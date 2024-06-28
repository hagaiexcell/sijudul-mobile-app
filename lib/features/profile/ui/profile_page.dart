import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('userData');
    if (userDataJson != null) {
      final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
      return userData['id'];
    }
    return null;
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');
    prefs.remove('userData');
    // ignore: use_build_context_synchronously
    context.read<ProfileBloc>().add(ProfileLogoutEvent());

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    _getUserId().then((id) {
      if (id != null) {
        context.read<ProfileBloc>().add(ProfileFetchEvent(id: id));
      }
    });

    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoadedState) {
            // print(state.userData);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(228, 228, 228, 1),
                        image: const DecorationImage(
                          image: AssetImage(
                              "lib/resources/images/empty-profile.png"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.userData['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      state.userData['nim'],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      state.userData['prodi'] == "Sarjana Informatika"
                          ? "S1 - Informatika"
                          : state.userData['prodi'] ==
                                  "Sarjana Sistem Informasi"
                              ? "S1 - Sistem Informasi"
                              : state.userData['prodi'] == "Diploma"
                                  ? "D3 - Sistem Informasi"
                                  : "",
                    ),
                    // const SizedBox(
                    //   height: 4,
                    // ),
                    // Text(
                    //   state.userData['email'],
                    // ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButtonWithCustomStyle(
                      text: "EDIT PROFILE",
                      onPressed: () {
                        Navigator.of(context).pushNamed('/edit-profile');
                      },
                      // icon: "lib/resources/images/ic-logout.svg",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButtonWithCustomStyle(
                      text: "LOGOUT",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Logout',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600)),
                              content:
                                  const Text("Apakah Anda Yakin Ingin Logout?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    logout(context);
                                  },
                                  child: const Text(
                                    'YA',
                                    style: TextStyle(color: AppColors.success),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Menutup dialog
                                  },
                                  child: const Text(
                                    'TIDAK',
                                    style: TextStyle(color: AppColors.danger),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: "lib/resources/images/ic-logout.svg",
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProfileErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
