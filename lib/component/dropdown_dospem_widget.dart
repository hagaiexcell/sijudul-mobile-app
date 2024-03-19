import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class DropDownDospem extends StatelessWidget {
  const DropDownDospem({
    super.key,
    required this.items,
  });

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.bottomSheet(
          constraints: const BoxConstraints(maxHeight: 200),
          itemBuilder:
              (BuildContext context, String? item, bool isSelected) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              child: Row(children: [
                Text(
                  item ?? "",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "(Kuota : 2)",
                  style: TextStyle(
                      fontSize: 12, color: AppColors.primary),
                )
              ]),
            );
          },
          bottomSheetProps:
              const BottomSheetProps(backgroundColor: Colors.white)),
      items: items.toList(),
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
      onChanged: print,
    );
  }
}