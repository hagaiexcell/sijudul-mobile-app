import 'dart:convert';

class PostsDataUiModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostsDataUiModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostsDataUiModel.fromMap(Map<String, dynamic> map) {
    return PostsDataUiModel(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostsDataUiModel.fromJson(String source) =>
      PostsDataUiModel.fromMap(json.decode(source) as Map<String, dynamic>);
}