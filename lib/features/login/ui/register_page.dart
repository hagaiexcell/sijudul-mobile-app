import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/dropdown_custom2.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_project_skripsi/features/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginBloc registerBloc = context.read<LoginBloc>();
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is RegisterSubmitSuccessState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Success',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600)),
                  content: const Text('Berhasil Membuat Akun!'),
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
                Navigator.of(context).pushReplacementNamed('/login');
              });
            });
          } else if (state is RegisterSubmitFailureState) {
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
            child: SingleChildScrollView(
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
                        "Buat Akun",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Halo, Silakan Mendaftar Terlebih Dahulu"),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        name: "nama",
                        hintText: "Nama",
                        label: "Nama",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        name: "nim",
                        hintText: "NIM",
                        label: "NIM",
                        keyboardType: TextInputType.phone,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        name: "email",
                        hintText: "Email",
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        name: "password",
                        hintText: "Password",
                        label: "Password",
                        obsecure: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownButtonCustom2(
                        name: "prodi",
                        items: const ['Informatika', 'Sistem Informasi'],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'This field cannot be empty'),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        name: "angkatan",
                        hintText: "Angkatan",
                        label: "Angkatan",
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        name: "sks",
                        hintText: "SKS",
                        label: "SKS",
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButtonWithCustomStyle(
                        text: state is LoginLoadingState
                            ? "Loading..."
                            : state is LoginInitial
                                ? "Daftar"
                                : "",
                        onPressed: () {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            final nama =
                                formKey.currentState?.fields['nama']?.value;
                            final nim =
                                formKey.currentState?.fields['nim']?.value;
                            final email =
                                formKey.currentState?.fields['email']?.value;
                            final password =
                                formKey.currentState?.fields['password']?.value;
                            final prodi =
                                formKey.currentState?.fields['prodi']?.value;
                            final angkatan = int.tryParse(formKey
                                .currentState?.fields['angkatan']?.value);
                            final sks = int.tryParse(
                                formKey.currentState?.fields['sks']?.value);

                            registerBloc.add(RegisterSubmitEvent(
                                name: nama,
                                angkatan: angkatan,
                                email: email,
                                nim: nim,
                                password: password,
                                prodi: prodi,
                                sks: sks));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sudah Memiliki Akun?"),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () =>
                                Navigator.of(context).pushNamed('/login'),
                            child: const Text(
                              "Masuk Disini",
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
            ),
          );
        },
      ),
    );
  }
}
