// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_project_skripsi/features/dosen/model/dosen_model.dart';
import 'package:flutter_project_skripsi/features/login/model/user_model.dart';

class Pengajuan {
  int id;
  int mahasiswaId;
  String peminatan;
  String judul;
  String tempatPenelitian;
  String rumusanMasalah;
  int dospem1Id;
  Dosen dospem1;
  int dospem2Id;
  Dosen dospem2;
  String status;
  String notes;
  User mahasiswa;

  Pengajuan({
    required this.id,
    required this.mahasiswaId,
    required this.peminatan,
    required this.judul,
    required this.tempatPenelitian,
    required this.rumusanMasalah,
    required this.dospem1Id,
    required this.dospem1,
    required this.dospem2Id,
    required this.dospem2,
    required this.status,
    required this.notes,
    required this.mahasiswa,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'mahasiswaId': mahasiswaId,
      'peminatan': peminatan,
      'judul': judul,
      'tempatPenelitian': tempatPenelitian,
      'rumusanMasalah': rumusanMasalah,
      'dospem1Id': dospem1Id,
      'dospem1': dospem1.toMap(),
      'dospem2Id': dospem2Id,
      'dospem2': dospem2.toMap(),
      'status': status,
      'notes': notes,
      'mahasiswa': mahasiswa.toJson()
    };
  }

  factory Pengajuan.fromMap(Map<String, dynamic> map) {
    return Pengajuan(
      id: map['id'] ?? 0,
      mahasiswaId: map['mahasiswaId'] ?? 0,
      peminatan: map['peminatan'] ?? "",
      judul: map['judul'] ?? "",
      tempatPenelitian: map['tempatPenelitian'] ?? "",
      rumusanMasalah: map['rumusanMasalah'] ?? "",
      dospem1Id: map['dospem1Id'] ?? 0,
      dospem1: Dosen.fromMap(map['dospem1'] as Map<String, dynamic>),
      dospem2Id: map['dospem2Id'] ?? 0,
      dospem2: Dosen.fromMap(map['dospem2'] as Map<String, dynamic>),
      status: map['status_acc'] ?? "",
      notes: map['notes'] ?? "",
      mahasiswa: User.fromJson(map['mahasiswa'] as Map<String, dynamic>, ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pengajuan.fromJson(String source) =>
      Pengajuan.fromMap(json.decode(source) as Map<String, dynamic>);
}
