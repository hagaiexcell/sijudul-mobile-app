import 'package:flutter/material.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';

class TagStatus extends StatelessWidget {
  const TagStatus({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: status == "Approved By Dosen Pembimbing"
              ? AppColors.primary
              : status == "Accepted"
                  ? AppColors.success
                  : status == "Rejected"
                      ? AppColors.danger
                      : AppColors.secondary,
          borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        status,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
