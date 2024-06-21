import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/notifications/bloc/notification_bloc.dart';
// import 'package:flutter_project_skripsi/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_project_skripsi/utils/helper.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(NotificationFetchAllEvent());
    return Scaffold(
        appBar:
            AppBarWidget.defaultAppBar(title: "Pemberitahuan", context: context),
        body: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is NotificationFetchingErrorState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: Text(state.error),
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
            if (state is NotificationFetchingSuccessfulState) {
              // print(state.listNotifications[0].createdAt);
              return ListView.builder(
                itemCount: state.listNotifications.length,
                itemBuilder: (context, index) {
                  var createdAtFormatted =
                      formatDateTime(state.listNotifications[index].createdAt);

                  return InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        '/detail-judul',
                        arguments:
                            state.listNotifications[index].dataPengajuan.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [AppElevation.elevationPrimary],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.listNotifications[index].message,
                                      style: TextStyle(
                                          color: state
                                                          .listNotifications[
                                                              index]
                                                          .dataPengajuan
                                                          .status ==
                                                      "Pending" ||
                                                  state
                                                          .listNotifications[
                                                              index]
                                                          .dataPengajuan
                                                          .status ==
                                                      "Checking"
                                              ? AppColors.gray700
                                              : state
                                                          .listNotifications[
                                                              index]
                                                          .dataPengajuan
                                                          .status ==
                                                      "Approved"
                                                  ? AppColors.success
                                                  : state
                                                              .listNotifications[
                                                                  index]
                                                              .dataPengajuan
                                                              .status ==
                                                          "Rejected"
                                                      ? AppColors.danger
                                                      : AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      state.listNotifications[index]
                                          .dataPengajuan.judul,
                                      style: const TextStyle(
                                        color: AppColors.gray700,
                                        fontSize: 13,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                createdAtFormatted,
                                style: const TextStyle(
                                    color: AppColors.gray,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ));
  }
}
