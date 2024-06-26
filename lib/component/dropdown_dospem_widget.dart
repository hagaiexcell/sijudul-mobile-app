import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_skripsi/features/dosen/model/dosen_model.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class DropDownDospem extends StatelessWidget {
  const DropDownDospem({
    super.key,
    required this.items,
    required this.name,
    this.validator,
  });

  final List<Dosen> items;
  final String name;
  final FormFieldValidator<Dosen>? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: name,
        validator: validator,
        builder: (FormFieldState<Dosen?> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownSearch<Dosen>(
                popupProps: PopupProps.bottomSheet(
                    constraints: const BoxConstraints(maxHeight: 200),
                    itemBuilder:
                        (BuildContext context, Dosen? item, bool isSelected) {
                     
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(children: [
                          Expanded(
                            child: Text(
                              item?.name ?? "",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Kuota : ${(item?.kapasitas ?? 0) - (item?.mahasiswaBimbingan.length ?? 0)}",
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.primary),
                          )
                        ]),
                      );
                    },
                    bottomSheetProps:
                        const BottomSheetProps(backgroundColor: Colors.white)),
                items: items,
                itemAsString: (Dosen u) => u.name,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: name == "dosen1"
                        ? "Pilih Dosen Pembimbing 1"
                        : "Pilih Dosen Pembimbing 2",
                    hintStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)),
                  ),
                ),
                onChanged: (Dosen? value) {
                  field.didChange(value);
                  FormBuilder.of(context)?.save(); // Save form state
                },
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(color: AppColors.danger),
                  ),
                ),
            ],
          );
        });
  }
}
