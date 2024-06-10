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
  });

  final List<Dosen> items;
  final String name;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: name,
        builder: (FormFieldState<Dosen?> field) {
          return DropdownSearch<Dosen>(
            popupProps: PopupProps.bottomSheet(
                constraints: const BoxConstraints(maxHeight: 200),
                itemBuilder:
                    (BuildContext context, Dosen? item, bool isSelected) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(children: [
                      Text(
                        item?.name ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "(Kuota : ${item?.kapasitas ?? ""})",
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
                hintText: "Pilih Dosen Pembimbing 1",
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
          );
        });
  }
}
