import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/component/dropdown_dospem_widget.dart';
import 'package:flutter_project_skripsi/component/label_form_widget.dart';
import 'package:flutter_project_skripsi/component/text_area_widget.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/features/dosen/bloc/dosen1_bloc.dart';
import 'package:flutter_project_skripsi/features/pengajuan/bloc/pengajuan_bloc.dart';
import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PengajuanCreatePage extends StatelessWidget
    implements PreferredSizeWidget {
  PengajuanCreatePage({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    PengajuanBloc pengajuanBloc = context.read<PengajuanBloc>();
    Dosen1Bloc dosen1bloc = context.read<Dosen1Bloc>();

    dosen1bloc.add(const DosenInitialFetchEvent(type: 'dosen1'));
    dosen1bloc.add(const DosenInitialFetchEvent(type: 'dosen2'));

    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar:
          AppBarWidget.defaultAppBar(title: "Ajukan Judul", context: context),
      body: SingleChildScrollView(
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
            } else if (state is PengajuanCreateErrorState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Failed'),
                    content: const Text("Gagal Mengajukan Judul!"),
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
            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
              child: FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      const LabelFormWidget(labelText: "Peminatan"),
                      TextFieldWidget(
                          name: "peminatan",
                          hintText: "Peminatan",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ])),
                      const SizedBox(
                        height: 16,
                      ),
                      const LabelFormWidget(labelText: "Judul Proposal"),
                      TextFieldWidget(
                          name: "judul",
                          hintText: "Judul",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ])),
                      const SizedBox(
                        height: 16,
                      ),
                      const LabelFormWidget(labelText: "Tempat Penelitian"),
                      TextFieldWidget(
                          name: "tempatpenelitian",
                          hintText: "Tempat Penelitian",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ])),
                      const SizedBox(
                        height: 16,
                      ),
                      const LabelFormWidget(labelText: "Rumusan Masalah"),
                      TextAreaWidget(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        hintText: "Rumusan Masalah",
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
                      const LabelFormWidget(labelText: "Dosen Pembimbing 1"),
                      BlocBuilder<Dosen1Bloc, Dosen1State>(
                        buildWhen: (previous, current) =>
                            current is Dosen1FetchingSuccessfulState &&
                            current.type == 'dosen1',
                        builder: (context, state) {
                          if (state is DosenLoadingState &&
                              state.type == 'dosen1') {
                            return const CircularProgressIndicator();
                          } else if (state is Dosen1FetchingSuccessfulState &&
                              state.type == 'dosen1') {
                            return DropDownDospem(
                              items: state.listDosen,
                              name: "dosen1",
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
                      const LabelFormWidget(labelText: "Dosen Pembimbing 2"),
                      BlocBuilder<Dosen1Bloc, Dosen1State>(
                        buildWhen: (previous, current) =>
                            current is Dosen2FetchingSuccessfulState &&
                            current.type == 'dosen2',
                        builder: (context, state) {
                          if (state is DosenLoadingState &&
                              state.type == 'dosen2') {
                            return const CircularProgressIndicator();
                          } else if (state is Dosen2FetchingSuccessfulState &&
                              state.type == 'dosen2') {
                            return DropDownDospem(
                              items: state.listDosen,
                              name: "dosen2",
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
                        text: "Submit",
                        onPressed: () {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            final peminatan = formKey
                                .currentState?.fields['peminatan']?.value;
                            final judul =
                                formKey.currentState?.fields['judul']?.value;
                            final tempatPenelitian = formKey.currentState
                                ?.fields['tempatpenelitian']?.value;
                            final rumusanMasalah = formKey
                                .currentState?.fields['rumusanmasalah']?.value;
                            final dosen1 = formKey.currentState
                                ?.fields['dosen1']?.value?.id; // Get dospem_id
                            final dosen2 = formKey.currentState
                                ?.fields['dosen2']?.value?.id; // Get dospem_id
                            // debugPrint(
                            //     '$peminatan,$judul,$tempatPenelitian,$rumusanMasalah');
                            pengajuanBloc.add(PengajuanCreateEvent(
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppColors.danger,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Maaf, judul yang Anda ajukan memiliki kemiripan yang tinggi dengan judul yang sudah ada. Harap ajukan judul lain.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
