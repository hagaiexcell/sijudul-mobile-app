import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropdownButtonCustom2 extends StatelessWidget {
  final String name;
  final List<String> items;
  final FormFieldValidator<String>? validator;

  const DropdownButtonCustom2({
    super.key,
    required this.name,
    required this.items,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      validator: validator,
      builder: (FormFieldState<String?> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              hint: const Text('PRODI'),
              value: field.value,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
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
                      color: item == field.value ? AppColors.primary : Colors.black,
                    ),
                  );
                }).toList();
              },
              onChanged: (value) {
                field.didChange(value);
                FormBuilder.of(context)?.save();
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
