import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoppizel/core/service/gimini.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import '../../../../../core/function/on_pop.dart';
import '../../data/model/message_model.dart';
import '../widget/chat_bubble_loading.dart';
import '../widget/empty_chat.dart';
import '../widget/message_bubble.dart';
import '../widget/send_prompt.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Message> messages = [];

  TextEditingController textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;

  File? image;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          onWillPop(context, "you will lose chat ,Do you want to go back?"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: messages.isNotEmpty
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                            message: messages.reversed.toList()[index]);
                      },
                    ),
                  ),
                  _isLoading ? const MessageBubbleLoading() : const SizedBox(),
                  Container(
                    color: AppConstants.appColor,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SendPrompt(

                          textController: textController,
                          selectedImg: (value){
                              image = value ;
                          },
                          sendMessage: _sendMessage,
                        )),
                  ),
                ],
              )
            : EmptyAiChat(controller: textController, sendMessage: _sendMessage, selectedimg:(value){
             image  = value ;
        })
      ),
    );
  }

  void _sendMessage() async {
    String prompt = "";
    if (textController.text.isNotEmpty) {
      prompt = textController.text;
      textController.clear();
      setState(() {
        messages.add(Message(
            img: image,
            text: prompt,
            isBot: false,
            time: DateFormat("h:m a").format(DateTime.now())));
        _scrollController.animateTo(0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
        _isLoading = true;
      });
      print(prompt) ;
      if (image != null) {
        String? response =
            await geminiTextAndPhoto(image: image!, text: prompt);
        setState(() {
          image = null;
          messages.add(Message(
              text: response ?? "sorry i cant reply",
              isBot: true,
              time: DateFormat("h:m a").format(DateTime.now())));
          _isLoading = false;
        });
      } else {
        String? response = await geminiText(text: prompt);
        setState(() {
          messages.add(Message(
              text: response ?? "sorry i cant reply",
              isBot: true,
              time: DateFormat("h:m a").format(DateTime.now())));
          _isLoading = false;
        });
        print(response) ;
      }
    }
  }
}

