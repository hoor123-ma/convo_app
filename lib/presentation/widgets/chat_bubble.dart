import 'package:chat_app/const/app_colors.dart';
import 'package:chat_app/const/page_routes.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/helper/firebase_instance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/const/app_text.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showMessageOptions(context, message);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.green1,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Wrap(
            children: [
              Text(
                message.content,
                style: TextStyle(color: AppColors.blue, fontSize: 15),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  message.isEdited
                      ? "Edited ${DateFormat('hh:mm a').format(message.createdAt)}"
                      : DateFormat('hh:mm a').format(message.createdAt),

                  style: TextStyle(color: Colors.black54, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  final MessageModel message;
  const ChatBubbleForFriend({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showMessageOptions(context, message);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Wrap(
            children: [
              Text(
                message.content,
                style: TextStyle(color: AppColors.blue, fontSize: 15),
              ),
              SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  message.isEdited
                      ? "Edited ${DateFormat('hh:mm a').format(message.createdAt)}"
                      : DateFormat('hh:mm a').format(message.createdAt),

                  style: TextStyle(color: Colors.black54, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showMessageOptions(BuildContext parentContext, MessageModel message) {
  showModalBottomSheet(
    context: parentContext,
    builder: (bottomSheetContext) {
      return SafeArea(
        child: Wrap(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.green2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Message'),
                onTap: () async {
                  Navigator.pop(bottomSheetContext); // نقفل الـ BottomSheet
                  await messagesCollection.doc(message.id).delete();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, left: 10, bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.green2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.edit, color: AppColors.green1),
                title: Text('Edit Message'),
                onTap: () {
                  Navigator.pop(bottomSheetContext); // مهم نقفل الـ BottomSheet
                  Navigator.of(
                    parentContext,
                  ).pushNamed(editScreen, arguments: message);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
