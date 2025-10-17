import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/const/app_text.dart';

class MessageModel {
  String content;
  final DateTime createdAt;
  final String currentUserEmail;
  final String id;
  bool isEdited;
  MessageModel({
    required this.id,
    required this.currentUserEmail,
    required this.content,
    required this.createdAt,
    this.isEdited = false,
  });

  Map<String, dynamic> toMap() {
    return {AppTexts.contentField: content, AppTexts.createdAtField: createdAt};
  }

  factory MessageModel.fromMap(map, id) {
    return MessageModel(
      id: id,
      isEdited: map[AppTexts.isEditedField] ?? false,
      currentUserEmail: map[AppTexts.currentUserEmailField],
      content: map[AppTexts.contentField],
      createdAt: (map[AppTexts.createdAtField] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>, '');
}
