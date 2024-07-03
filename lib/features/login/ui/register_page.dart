import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/component/dropdown_custom2.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_project_skripsi/features/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginBloc registerBloc = context.read<LoginBloc>();
    final formKey = GlobalKey<FormBuilderState>();
    final TextEditingController dateController = TextEditingController();

    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.single,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    Future<void> _selectDate(BuildContext context, FormFieldState field) async {
      final config = CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.single,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        currentDate: DateTime.now(),
      );

      final List<DateTime>? picked = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: CalendarDatePicker2(
              config: config,
              value: field.value != null ? [field.value] : [],
              onValueChanged: (dates) {
                if (dates.isNotEmpty) {
                  field.didChange(dates[0]);
                  dateController.text =
                      dates[0].toLocal().toString().split(' ')[0];
                }
              },
            ),
          );
        },
      );

      if (picked != null && picked.isNotEmpty) {
        field.didChange(picked.first);
        dateController.text = picked.first.toLocal().toString().split(' ')[0];
      }
    }

    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
        title: "Register",
        showLeading: false,
        context: context,
      ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      DropdownButtonCustom2(
                        hint: "Prodi",
                        name: "prodi",
                        items: const [
                          'S1 Informatika',
                          'S1 Sistem Informasi',
                          'D3 Sistem Informasi'
                        ],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'This field cannot be empty'),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        name: "tempatlahir",
                        hintText: "Tempat Lahir",
                        label: "Tempat Lahir",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FormBuilderField(
                        name: 'tanggallahir',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'This field cannot be empty',
                          ),
                        ]),
                        builder: (FormFieldState<dynamic> field) {
                          // Update the dateController text whenever field value changes
                          if (field.value != null &&
                              dateController.text.isEmpty) {
                            dateController.text = (field.value as DateTime)
                                .toLocal()
                                .toString()
                                .split(' ')[0];
                          }

                          return Container(
                            width: double.infinity,
                            height: 55,
                            child: InkWell(
                              onTap: () async {
                                final config = CalendarDatePicker2Config(
                                  calendarType: CalendarDatePicker2Type.single,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                  currentDate: DateTime.now(),
                                );

                                final List<DateTime>? picked = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: CalendarDatePicker2(
                                        config: config,
                                        value: field.value != null
                                            ? [field.value]
                                            : [],
                                        onValueChanged: (dates) {
                                          if (dates.isNotEmpty) {
                                            field.didChange(dates[0]);
                                            dateController.text = dates[0]
                                                .toLocal()
                                                .toString()
                                                .split(' ')[0];
                                          }
                                        },
                                      ),
                                    );
                                  },
                                );

                                if (picked != null && picked.isNotEmpty) {
                                  field.didChange(picked.first);
                                  dateController.text = picked.first
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                }
                              },
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Tanggal Lahir',
                                  errorText: field.errorText,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.primary, width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.danger, width: 1),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    dateController.text.isEmpty
                                        ? 'Pilih Tanggal Lahir'
                                        : dateController.text,
                                    style: dateController.text.isEmpty
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: AppColors.gray700)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: AppColors.textColour90),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropdownButtonCustom2(
                        hint: "Jenis Kelamin",
                        name: "jeniskelamin",
                        items: const [
                          'Pria',
                          'Wanita',
                        ],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'This field cannot be empty'),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropdownButtonCustom2(
                        hint: "Agama",
                        name: "agama",
                        items: const [
                          'Islam',
                          'Katolik',
                          'Protestan',
                          'Hindu',
                          'Buddha',
                          'Khonghucu'
                        ],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'This field cannot be empty'),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        name: "notelpon",
                        hintText: "No Telpon",
                        label: "No Telpon",
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
                            final tempatLahir = formKey
                                .currentState?.fields['tempatlahir']?.value;
                            final tanggalLahir = formKey
                                .currentState?.fields['tanggallahir']?.value;
                            String? tanggalLahirStr = tanggalLahir
                                ?.toLocal()
                                .toString()
                                .split(' ')[0];
                            final jenisKelamin = formKey
                                .currentState?.fields['jeniskelamin']?.value;
                            final agama =
                                formKey.currentState?.fields['agama']?.value;
                            final noTelpon =
                                formKey.currentState?.fields['notelpon']?.value;
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
                                tempatLahir: tempatLahir,
                                tanggalLahir: tanggalLahirStr,
                                jenisKelamin: jenisKelamin,
                                agama: agama,
                                noTelpon: noTelpon,
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
