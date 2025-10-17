// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/helper/firebase_instance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/const/app_colors.dart';
import 'package:chat_app/const/app_text.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/presentation/widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String email;
  ChatScreen({Key? key, required this.email}) : super(key: key);
  static const String id = '/chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  ScrollController listViewController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/undraw_respond_o54z.png',
                  fit: BoxFit.cover,
                  height: 45,
                  width: 45,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Chat App",
                style: TextStyle(fontSize: 20, color: AppColors.white),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.green1,
        foregroundColor: AppColors.white,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(child: buildChatScreenBody()),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildChatScreenBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: messagesCollection
          .orderBy(AppTexts.createdAtField, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var docs = snapshot.data!.docs;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: listViewController,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var message = MessageModel.fromMap(
                      docs[index].data() as Map<String, dynamic>,
                      docs[index].id,
                    );
                    return (message.currentUserEmail == widget.email)
                        ? ChatBubble(message: message)
                        : ChatBubbleForFriend(message: message);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  messageController: messageController,
                  onSend: addMessage,
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void addMessage() async {
    if (messageController.text.isNotEmpty) {
      messagesCollection.add({
        AppTexts.contentField: messageController.text,
        AppTexts.createdAtField: DateTime.now(),
        AppTexts.currentUserEmailField: widget.email,
        AppTexts.isEditedField: false,
      });
      messageController.clear();

      listViewController.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    listViewController.dispose();
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.messageController,
    required this.onSend,
  });
  final TextEditingController messageController;
  void Function() onSend;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageController,
      onSubmitted: (value) {
        onSend();
      },
      cursorColor: AppColors.blue,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            onSend();
          },
          icon: Icon(Icons.send, color: AppColors.blue),
        ),
        hintText: "Send Message",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.green1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.green1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.green1),
        ),
      ),
    );
  }
}
