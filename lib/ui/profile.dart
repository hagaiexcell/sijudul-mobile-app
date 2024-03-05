import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                    color: Color.fromRGBO(228, 228, 228, 1),
                    image: DecorationImage(
                        image: AssetImage(
                            "lib/resources/images/empty-profile.png"))),
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                "Marwahal Hagai Excellent",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text("2010511072"),
              SizedBox(
                height: 24,
              ),
              ElevatedButtonWithCustomStyle(
                text: "LOGOUT",
                onPressed: () {},
                icon: "lib/resources/images/ic-logout.svg",
              )
            ],
          ),
        ),
      ),
    );
  }
}
