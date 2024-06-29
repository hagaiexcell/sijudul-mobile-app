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
  String image;
  List mahasiswaBimbingan;
  String noTelp;
  String gelar;
  String jenjangAkademik;

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
    required this.mahasiswaBimbingan,
    required this.image,
    required this.noTelp,
    required this.gelar,
    required this.jenjangAkademik,
  });

  factory Dosen.fromMap(Map<String, dynamic> json) {
    return Dosen(
        id: json['id'] ?? -1,
        name: json['name'] ?? "",
        nidn: json['nidn'] ?? "",
        email: json['email'] ?? "",
        prodi: json['prodi'] ?? "",
        image: json['image'] ?? "",
        kapasitas: json['kapasitas'] ?? 0,
        totalMahasiswa: json['total_mahasiswa'] ?? 0,
        jabatan: json['jabatan'] ?? "",
        mahasiswaBimbingan: json['mahasiswa_bimbingan_id'] ?? [],
        kepakaran: json['kepakaran'] ?? "",
        noTelp: json['no_telp'] ?? "",
        gelar: json['gelar'] ?? "",
        jenjangAkademik: json['jenjang_akademik'] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nidn': nidn,
      'email': email,
      'prodi': prodi,
      'image': image,
      'kapasitas': kapasitas,
      'total_mahasiswa': totalMahasiswa,
      'jabatan': jabatan,
      'kepakaran': kepakaran,
      'mahasiswa_bimbingan_id': mahasiswaBimbingan,
      'no_telp': noTelp,
      'gelar': gelar,
      'jenjang_akademik': jenjangAkademik,
    };
  }
}
