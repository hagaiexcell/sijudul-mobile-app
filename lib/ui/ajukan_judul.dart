import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/component/dropdown_dospem_widget.dart';
import 'package:flutter_project_skripsi/component/label_form_widget.dart';
import 'package:flutter_project_skripsi/component/text_area_widget.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class AjukanJudul extends StatelessWidget implements PreferredSizeWidget {
  AjukanJudul({super.key});
  final List<String> items = [
    'item1',
    'item1',
    'item1',
    'item1',
    'item1',
    'item1',
  ];

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarWidget.defaultAppBar(title: "Ajukan Judul", context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
          child: Column(
            children: [
              const LabelFormWidget(labelText: "Peminatan"),
              const TextFieldWidget(
                name: "peminatan",
                hintText: "Peminatan",
              ),
              const SizedBox(
                height: 16,
              ),
              const LabelFormWidget(labelText: "Judul Proposal"),
              const TextFieldWidget(
                name: "judul",
                hintText: "Judul",
              ),
              const SizedBox(
                height: 16,
              ),
              const LabelFormWidget(labelText: "Tempat Penelitian"),
              const TextFieldWidget(
                name: "tempat",
                hintText: "Tempat Penelitian",
              ),
              const SizedBox(
                height: 16,
              ),
              const LabelFormWidget(labelText: "Rumusan Masalah"),
              const TextAreaWidget(
                hintText: "Rumusan Masalah",
                name: "rumusan",
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
              DropDownDospem(items: items),
              const SizedBox(
                height: 20,
              ),
              const LabelFormWidget(labelText: "Dosen Pembimbing 2"),
              DropDownDospem(items: items),
              const SizedBox(
                height: 20,
              ),
              ElevatedButtonWithCustomStyle(
                text: "Submit",
                onPressed: () {},
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
          ),
        ),
      ),
    );
  }
}
