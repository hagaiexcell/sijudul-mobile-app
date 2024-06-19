import 'package:flutter_project_skripsi/features/pengajuan/model/pengajuan_model.dart';

class Notifications {
  Pengajuan dataPengajuan;
  int id;
  int mahasiswaId;
  String message;
  // String createdAt;

  Notifications({
    required this.dataPengajuan,
    required this.id,
    required this.mahasiswaId,
    required this.message,
    // required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataPengajuan': dataPengajuan.toMap(),
      'id': id,
      'mahasiswaId': mahasiswaId,
      'message': message,
      // 'createdAt': createdAt
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      dataPengajuan: Pengajuan.fromMap(map['data_pengajuan']),
      id: map['data_pengajuan_id'],
      mahasiswaId: map['id'] ?? 0,
      message: map['message'],
      // createdAt: map['CreatedAt']
    );
  }
}
