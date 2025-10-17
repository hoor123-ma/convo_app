// Create a CollectionReference called users that references the firestore collection
import 'package:chat_app/const/app_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference messagesCollection = FirebaseFirestore.instance.collection(
  AppTexts.messageCollection,
);
