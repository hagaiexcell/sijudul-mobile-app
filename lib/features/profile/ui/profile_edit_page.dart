import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/component/dropdown_custom2.dart';
import 'package:flutter_project_skripsi/component/label_form_widget.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('userData');
    if (userDataJson != null) {
      final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
      return userData['id'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    _getUserId().then((id) {
      if (id != null) {
        context.read<ProfileBloc>().add(ProfileFetchEvent(id: id));
      }
    });
    final formKey = GlobalKey<FormBuilderState>();
    final TextEditingController dateController = TextEditingController();

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
            title: "Edit Profile",
            context: context,
            showLeading: true,
            onLeadingTap: () {
              Navigator.of(context).pop();
            }),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoadedState) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [AppElevation.elevationPrimary],
                            color: Colors.white),
                        child: FormBuilder(
                          key: formKey,
                          child: Column(
                            children: [
                              // Container(
                              //   height: 150,
                              //   width: 150,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     color: const Color.fromRGBO(228, 228, 228, 1),
                              //     image: const DecorationImage(
                              //       image: AssetImage(
                              //           "lib/resources/images/empty-profile.png"),
                              //     ),
                              //   ),
                              // ),

                              const LabelFormWidget(labelText: "Nama"),
                              TextFieldWidget(
                                name: "name",
                                hintText: "Nama",
                                initialValue: state.userData['name'] ??
                                    '', // Provide default value
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const LabelFormWidget(labelText: "Email"),
                              TextFieldWidget(
                                name: "email",
                                hintText: "Email",
                                initialValue: state.userData['email'] ??
                                    '', // Provide default value
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const LabelFormWidget(labelText: "No Telpon"),
                              TextFieldWidget(
                                name: "notelpon",
                                hintText: "No Telpon",
                                initialValue: state.userData['no_telp'] ??
                                    '', // Provide default value
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const LabelFormWidget(labelText: "Tempat Lahir"),
                              TextFieldWidget(
                                name: "tempatlahir",
                                hintText: "Tempat Lahir",
                                initialValue: state.userData['tempat_lahir'] ??
                                    '', // Provide default value
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const LabelFormWidget(labelText: "Tanggal Lahir"),
                              FormBuilderField(
                                name: 'tanggallahir',
                                initialValue:
                                    state.userData['tanggal_lahir'] != null
                                        ? DateTime.parse(
                                            state.userData['tanggal_lahir'])
                                        : null,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                    errorText: 'This field cannot be empty',
                                  ),
                                ]),
                                builder: (FormFieldState<dynamic> field) {
                                  // Update the dateController text whenever field value changes
                                  if (field.value != null &&
                                      dateController.text.isEmpty) {
                                    dateController.text =
                                        (field.value as DateTime)
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0];
                                  }

                                  return Container(
                                    width: double.infinity,
                                    height: 55,
                                    child: InkWell(
                                      onTap: () async {
                                        final config =
                                            CalendarDatePicker2Config(
                                          calendarType:
                                              CalendarDatePicker2Type.single,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                          currentDate: DateTime.now(),
                                        );

                                        final List<DateTime>? picked =
                                            await showDialog(
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
                                                    dateController.text =
                                                        dates[0]
                                                            .toLocal()
                                                            .toString()
                                                            .split(' ')[0];
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        );

                                        if (picked != null &&
                                            picked.isNotEmpty) {
                                          field.didChange(picked.first);
                                          dateController.text = picked.first
                                              .toLocal()
                                              .toString()
                                              .split(' ')[0];
                                        }
                                      },
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          errorText: field.errorText,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: AppColors.primary,
                                                width: 1),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: AppColors.danger,
                                                width: 1),
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
                                                    .copyWith(
                                                        color:
                                                            AppColors.gray700)
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color:
                                                            AppColors.primary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const LabelFormWidget(labelText: "Jenis Kelamin"),
                              DropdownButtonCustom2(
                                initialValue: state.userData['jenis_kelamin'] ??
                                    'Pria', // Provide default value
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
                                height: 12,
                              ),
                              const LabelFormWidget(labelText: "Agama"),
                              DropdownButtonCustom2(
                                initialValue: state.userData['agama'] ??
                                    'Islam', // Provide default value
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      ElevatedButtonWithCustomStyle(
                        text: "SUBMIT",
                        onPressed: () async {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            final userId = await _getUserId();

                            final email =
                                formKey.currentState?.fields['email']?.value;
                            final name =
                                formKey.currentState?.fields['name']?.value;
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

                            profileBloc.add(ProfileUpdateEvent(
                                email: email,
                                name: name,
                                id: userId,
                                tempatLahir: tempatLahir,
                                tanggalLahir: tanggalLahirStr,
                                jenisKelamin: jenisKelamin,
                                agama: agama,
                                noTelpon: noTelpon));

                            // Navigator.of(context)
                            //     .pushReplacementNamed('/profile');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ));
  }
}
