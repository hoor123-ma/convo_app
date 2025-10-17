import 'package:chat_app/const/app_colors.dart';
import 'package:chat_app/const/app_text.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/helper/firebase_instance.dart';
import 'package:chat_app/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final MessageModel message;
  static const String id = "/editScreen";
  EditScreen({super.key, required this.message});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController textController;
  late FocusNode focusNode;
  late String oldMessage;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.message.content);
    oldMessage = widget.message.content;
    focusNode = FocusNode();
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green1,
        foregroundColor: AppColors.white,
        title: const Text("Edit Message", style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: editMessage),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            Controller: textController,
            focusNode: focusNode,
            onSubmitted: (value) => editMessage(),
          ),
        ),
      ),
    );
  }

  void editMessage() {
    messagesCollection.doc(widget.message.id).update({
      AppTexts.contentField: textController.text,
      AppTexts.isEditedField: oldMessage == textController.text ? false : true,
    });
    Navigator.pop(context);
  }
}
