import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "lib/resources/images/logo-upn-big.png",
                width: 113,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Masuk Akun",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text("Halo, selamat datang di SiJuDul"),
              const SizedBox(
                height: 16,
              ),
              const TextFieldWidget(
                name: "nim",
                hintText: "NIM",
                label: "NIM",
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 16,
              ),
              const TextFieldWidget(
                name: "password",
                hintText: "Password",
                label: "Password",
                obsecure: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButtonWithCustomStyle(
                text: "MASUK",
                onPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun?"),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed('/register'),
                    child: const Text(
                      "Daftar Disini",
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
