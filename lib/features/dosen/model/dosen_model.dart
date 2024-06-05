class Dosen {
  int id;
  String name;
  String nidn;
  String email;
  String prodi;
  int kapasitas;
  int totalMahasiswa;
  String jabatan;
  String kepakaran;


  Dosen({
    required this.id,
    required this.name,
    required this.nidn,
    required this.email,
    required this.prodi,
    required this.kapasitas,
    required this.totalMahasiswa,
    required this.jabatan,
    required this.kepakaran,
  });

  factory Dosen.fromMap(Map<String, dynamic> json) {
    return Dosen(
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
      nidn: json['nidn'] ?? "",
      email: json['email'] ?? "",
      prodi: json['prodi'] ?? "",
      kapasitas: json['kapasitas'] ??
          0, 
      totalMahasiswa: json['total_mahasiswa'] ??
          0, 
          jabatan: json['jabatan'] ?? "",
          kepakaran: json['kepakaran'] ?? ""
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nidn': nidn,
      'email': email,
      'prodi': prodi,
      'kapasitas': kapasitas,
      'total_mahasiswa': totalMahasiswa,
      'jabatan': jabatan,
      'kepakaran': kepakaran
    };
  }
}
