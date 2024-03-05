import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class AjukanJudul extends StatelessWidget implements PreferredSizeWidget {
  const AjukanJudul({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarWidget.defaultAppBar(title: "Ajukan Judul", context: context),
      body: Text("ad"),
    );
  }
}
