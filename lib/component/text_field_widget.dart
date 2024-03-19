import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.name,
    required this.hintText,
    this.initialValue,
    this.label,
    this.enabled = true,
    this.obsecure = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.suffixIcon,
  }) : super(key: key);

  final String name;
  final String hintText;
  final String? label;
  final Widget? suffixIcon;
  final bool enabled;
  final bool obsecure;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      name: name,
      enabled: enabled,
      obscureText: obsecure,
      initialValue: initialValue,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.primary),
      decoration: InputDecoration(
        fillColor: enabled ? Colors.transparent : AppColors.textColour10,
        labelText: label,
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.gray700),
        errorStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.danger),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.danger, width: 1),
        ),
      ),
    );
  }
}
