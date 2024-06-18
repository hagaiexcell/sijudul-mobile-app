import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
        appBar:
            AppBarWidget.defaultAppBar(title: "Notifikasi", context: context),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom:10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [AppElevation.elevationPrimary],
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Judul Anda telah diterima!",
                              style: TextStyle(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Rancang Bangun Aplikasi SiJuDul Dengan Framework Flutter",
                              style: TextStyle(
                                color: AppColors.gray700,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "07:10 am",
                        style: TextStyle(
                            color: AppColors.gray,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
