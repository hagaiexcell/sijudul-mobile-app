import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/component/label_form_widget.dart';
import 'package:flutter_project_skripsi/component/text_field_widget.dart';
import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('userData');
    if (userDataJson != null) {
      final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
      return userData['id'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    _getUserId().then((id) {
      if (id != null) {
        context.read<ProfileBloc>().add(ProfileFetchEvent(id: id));
      }
    });
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
        appBar: AppBarWidget.defaultAppBar(
            title: "Edit Profile",
            context: context,
            showLeading: true,
            onLeadingTap: () {
              Navigator.of(context).pop();
            }),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoadedState) {
              return SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [AppElevation.elevationPrimary],
                            color: Colors.white),
                        child: FormBuilder(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(228, 228, 228, 1),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "lib/resources/images/empty-profile.png"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const LabelFormWidget(labelText: "Nama"),
                              TextFieldWidget(
                                name: "name",
                                hintText: "Nama",
                                initialValue: state.userData['name'],
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const LabelFormWidget(labelText: "Email"),
                              TextFieldWidget(
                                name: "email",
                                hintText: "Email",
                                initialValue: state.userData['email'],
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      ElevatedButtonWithCustomStyle(
                        text: "SUBMIT",
                        onPressed: () async {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            final userId = await _getUserId();

                            final email =
                                formKey.currentState?.fields['email']?.value;
                            final name =
                                formKey.currentState?.fields['name']?.value;

                            profileBloc.add(ProfileUpdateEvent(
                                email: email, name: name, id: userId));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ));
  }
}
