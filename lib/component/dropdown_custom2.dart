import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropdownButtonCustom2 extends StatelessWidget {
  final String name;
  final String hint;
  final List<String> items;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final String? initialValue;

  const DropdownButtonCustom2({
    super.key,
    required this.name,
    required this.hint,
    required this.items,
    this.validator,
    this.onChanged,
    this.initialValue
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<String?> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.primary), // Change to your desired color
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              hint: Text(hint),
              value: field.value,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item == "S1 Informatika"
                            ? "Sarjana Informatika"
                            : item == "S1 Sistem Informasi"
                                ? "Sarjana Sistem Informasi"
                                : item == "D3 Sistem Informasi"
                                    ? "Diploma Sistem Informasi"
                                    : item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) {
                return items.map((item) {
                  return Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      color: item == field.value
                          ? AppColors.textColour90
                          : Colors.black,
                    ),
                  );
                }).toList();
              },
              onChanged: (value) {
                field.didChange(value);
                if (onChanged != null) {
                  onChanged!(value);
                }
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
      },
    );
  }
}
