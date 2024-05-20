import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'auth_token'); // Ensure 'auth_token' is the key you're using to store the token

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                    image: AssetImage("lib/resources/images/empty-profile.png"),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Marwahal Hagai Excellent",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Text("2010511072"),
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
                        title: const Text('Logout'),
                        content: const Text("Apakah Anda Yakin Ingin Logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              logout(context);
                            },
                            child: const Text('YA'),
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
      ),
    );
  }
}
