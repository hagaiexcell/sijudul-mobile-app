import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/component/dropdown_dospem_widget.dart';
import 'package:flutter_project_skripsi/component/label_form_widget.dart';
import 'package:flutter_project_skripsi/component/text_area_widget.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/features/dosen/bloc/dosen1_bloc.dart';
import 'package:flutter_project_skripsi/features/pengajuan/bloc/pengajuan_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_project_skripsi/component/dropdown_custom2.dart';

class PengajuanCreatePage extends StatelessWidget
    implements PreferredSizeWidget {
  const PengajuanCreatePage({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('userData');
    // print(userDataJson);
    if (userDataJson != null) {
      final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
      // print(userData);
      // prodi = userData['prodi'];
      return userData['id'];
    }
    return null;
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('userData');
    if (userDataJson != null) {
      final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
      return userData;
    }
    throw Exception('User data not found');
  }

  @override
  Widget build(BuildContext context) {
    _getUserId();
    PengajuanBloc pengajuanBloc = context.read<PengajuanBloc>();
    Dosen1Bloc dosen1bloc = context.read<Dosen1Bloc>();

    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBarWidget.defaultAppBar(
          title: "Ajukan Judul", context: context, showLeading: false),
      body: FutureBuilder<Map<String, dynamic>>(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final userData = snapshot.data!;
              final userId = userData['id'];
              final prodi = userData['prodi'];
              // print(prodi);

              dosen1bloc.add(DosenInitialFetchEvent(type: 'dosen1'));
              dosen1bloc.add(DosenInitialFetchEvent(type: 'dosen2'));
              return SingleChildScrollView(
                child: BlocConsumer<PengajuanBloc, PengajuanState>(
                  listener: (context, state) {
                    if (state is PengajuanCreateSuccessfullState) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Success',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600)),
                            content: const Text('Berhasil Mengajukan Judul!'),
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
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 30),
                      child: FormBuilder(
                          key: formKey,
                          child: Column(
                            children: [
                              const LabelFormWidget(labelText: "Peminatan"),
                              // TextFieldWidget(
                              //     name: "peminatan",
                              //     hintText: "Peminatan",
                              //     validator: FormBuilderValidators.compose([
                              //       FormBuilderValidators.required(),
                              //     ])),
                              DropdownButtonCustom2(
                                hint: "Peminatan",
                                name: "peminatan",
                                items: const [
                                  'IT Security Specialist',
                                  'Software Engineer',
                                  'Network Engineer'
                                ],
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: 'This field cannot be empty'),
                                ]),
                                onChanged: (value) {
                                  if (value != null) {
                                    dosen1bloc.add(DosenInitialFetchEvent(
                                        type: 'dosen1',
                                        kepakaran: value,
                                        prodi: prodi));
                                    dosen1bloc.add(DosenInitialFetchEvent(
                                        type: 'dosen2',
                                        kepakaran: value,
                                        prodi: prodi));
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelFormWidget(
                                  labelText: "Judul Proposal"),
                              TextFieldWidget(
                                  name: "judul",
                                  hintText: "Judul",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ])),
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelFormWidget(
                                  labelText: "Tempat Penelitian"),
                              TextFieldWidget(
                                  name: "tempatpenelitian",
                                  hintText: "Tempat Penelitian",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ])),
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelFormWidget(labelText: "Abstrak"),
                              TextAreaWidget(
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                hintText: "Abstrak",
                                name: "rumusanmasalah",
                                // textAreaResult: controller.keteranganResult,
                                maxLength: 200,
                                // validator: Validator.list([
                                //   Validator.required(),
                                //   Validator.maxLength(200),
                                // ]),
                                // onChanged: (newVal) {
                                //   if(newVal != ""){
                                //     controller.keteranganResult.value = newVal!;
                                //   }
                                // },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelFormWidget(
                                  labelText: "Dosen Pembimbing 1"),
                              BlocBuilder<Dosen1Bloc, Dosen1State>(
                                buildWhen: (previous, current) {
                                  return (current
                                              is Dosen1FetchingSuccessfulState &&
                                          current.type == 'dosen1') ||
                                      (current is DosenLoadingState &&
                                          current.type == 'dosen1') ||
                                      (current is DosenFetchingErrorState &&
                                          current.type == 'dosen1');
                                },
                                builder: (context, state) {
                                  if (state is DosenLoadingState &&
                                      state.type == 'dosen1') {
                                    return const CircularProgressIndicator();
                                  } else if (state
                                          is Dosen1FetchingSuccessfulState &&
                                      state.type == 'dosen1') {
                                    return DropDownDospem(
                                      items: state.listDosen,
                                      name: "dosen1",
                                      validator: FormBuilderValidators.required(
                                          errorText: 'This field is required'),
                                    );
                                  } else if (state is DosenFetchingErrorState &&
                                      state.type == 'dosen1') {
                                    return Text(state.error);
                                  }
                                  return Container();
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const LabelFormWidget(
                                  labelText: "Dosen Pembimbing 2"),
                              BlocBuilder<Dosen1Bloc, Dosen1State>(
                                buildWhen: (previous, current) {
                                  return (current
                                              is Dosen2FetchingSuccessfulState &&
                                          current.type == 'dosen2') ||
                                      (current is DosenLoadingState &&
                                          current.type == 'dosen2') ||
                                      (current is DosenFetchingErrorState &&
                                          current.type == 'dosen2');
                                },
                                builder: (context, state) {
                                  if (state is DosenLoadingState &&
                                      state.type == 'dosen2') {
                                    return const CircularProgressIndicator();
                                  } else if (state
                                          is Dosen2FetchingSuccessfulState &&
                                      state.type == 'dosen2') {
                                    return DropDownDospem(
                                      items: state.listDosen,
                                      name: "dosen2",
                                      validator: FormBuilderValidators.required(
                                          errorText: 'This field is required'),
                                    );
                                  } else if (state is DosenFetchingErrorState &&
                                      state.type == 'dosen2') {
                                    return Text(state.error);
                                  }
                                  return Container();
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButtonWithCustomStyle(
                                text: state is PengajuanCreateLoadingState
                                    ? "Loading..."
                                    : "Submit",
                                onPressed: () async {
                                  if (formKey.currentState?.saveAndValidate() ??
                                      false) {
                                    final userId = await _getUserId();
                                    final peminatan = formKey.currentState
                                        ?.fields['peminatan']?.value;
                                    final judul = formKey
                                        .currentState?.fields['judul']?.value;
                                    final tempatPenelitian = formKey
                                        .currentState
                                        ?.fields['tempatpenelitian']
                                        ?.value;
                                    final rumusanMasalah = formKey.currentState
                                        ?.fields['rumusanmasalah']?.value;
                                    final dosen1 = formKey.currentState
                                        ?.fields['dosen1']?.value?.id;
                                    final dosen2 = formKey.currentState
                                        ?.fields['dosen2']?.value?.id;

                                    pengajuanBloc.add(PengajuanCreateEvent(
                                        userId: userId,
                                        peminatan: peminatan,
                                        judul: judul,
                                        rumusanMasalah: rumusanMasalah,
                                        tempatPenelitian: tempatPenelitian,
                                        dosen1Id: dosen1,
                                        dosen2Id: dosen2));
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (state is PengajuanCreateErrorState)
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: AppColors.danger,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    state.error,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ],
                          )),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text('No data'));
            }
          }),
    );
  }
}
