import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/features/login/bloc/login_bloc.dart';
import 'package:flutter_project_skripsi/features/posts/bloc/posts_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = context.read<LoginBloc>();
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => true,
        listener: (context, state) {
          if (state is LoginSubmitSuccessState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Success',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600)),
                  content: const Text('Berhasil Login, Selamat Datang!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK',
                          style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                );
              },
            ).then((_) {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushReplacementNamed('/home');
              });
            });
          } else if (state is LoginSubmitFailureState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Failed'),
                  content: Text(state.message),
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
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FormBuilder(
                key: formKey,
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
                      onPressed: () {
                        if (formKey.currentState?.saveAndValidate() ?? false) {
                          final nim =
                              formKey.currentState?.fields['nim']?.value;
                          final password =
                              formKey.currentState?.fields['password']?.value;
                          loginBloc.add(
                              LoginSubmitEvent(nim: nim, password: password));
                        }
                      },
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
                          onTap: () =>
                              Navigator.of(context).pushNamed('/register'),
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
        },
      ),
    );
  }
}
