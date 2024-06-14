// user_model.dart
class User {
  final int id;
  final String name;
  final String nim;
  final String email;
  final String prodi;
  final int angkatan;
  final int sks;
  final String token;
  final String image;

  User({
    required this.id,
    required this.name,
    required this.nim,
    required this.email,
    required this.prodi,
    required this.angkatan,
    required this.sks,
    required this.token,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json, String token) {
    return User(
      id: json['id'],
      name: json['name'],
      nim: json['nim'],
      email: json['email'],
      prodi: json['prodi'],
      angkatan: json['angkatan'],
      sks: json['sks'],
      token: token,
      image: json['image']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nim': nim,
      'email': email,
      'prodi': prodi,
      'angkatan': angkatan,
      'sks': sks,
      'token': token,
      'image' : image
    };
  }
}
