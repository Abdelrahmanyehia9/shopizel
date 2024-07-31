import 'package:flutter/material.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../screen/chatbot_screen.dart';

class ChatBotOverview extends StatelessWidget {
  const ChatBotOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI CHAT"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight(context) * .42,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight(context) * .15,
                      width: screenWidth(context),
                      child: Image.asset(
                          "assets/images/robot-friendly-chatbot-with-antenna-message-chat-vector-40420716-removebg-preview.png"),
                    ),
                    const Text(
                      " Hello! My name is T-robot iam here to help you to get most suitable outfit for you please ask me  ",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Example ...",
                      style: TextStyle(
                          color: AppConstants.appColor,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              PrimaryButton(
                label: "How can I improve an outfit?",
                color: Colors.white,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ChatBotScreen(
                                initialMessage: "How can I improve appearance of an outfit?",
                              )));
                },
              ),
              const SizedBox(
                height: 4,
              ),
              PrimaryButton(
                label: "give me outfit  for wedding party !",
                color: Colors.white,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ChatBotScreen(
                                initialMessage: "give me outfit example for wedding party !",
                              )));
                },
              ),
              const SizedBox(
                height: 4,
              ),
              PrimaryButton(
                label: "How can I discover defects in clothes?",
                color: Colors.white,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ChatBotScreen(
                                initialMessage: "How can I discover defects in clothes?",
                              )));
                },
              ),
              const SizedBox(
                height: 8,
              ),
              PrimaryButton(
                label: "Custom chat",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ChatBotScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
