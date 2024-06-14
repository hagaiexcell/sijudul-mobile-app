import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'auth_token'); // Ensure 'auth_token' is the key you're using to store the token

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileFetchEvent());
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoadedState) {
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
                      style:
                         const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      state.userData['nim'],
                    ),
                    const SizedBox(
                      height: 24,
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
                    )
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
