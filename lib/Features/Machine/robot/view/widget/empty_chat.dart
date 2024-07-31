import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/Machine/robot/view/widget/send_prompt.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';

class EmptyAiChat extends StatelessWidget {
  final TextEditingController controller ;
  final GestureTapCallback sendMessage ;
  final void Function(File?)selectedimg ;
  const EmptyAiChat({super.key ,required this.controller  , required this.sendMessage , required this.selectedimg});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight(context) * .3,
                    width: screenWidth(context) * .5,
                    child: Image.asset(
                      "assets/images/robot-friendly-chatbot-with-antenna-message-chat-vector-40420716-removebg-preview.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Hello ! 😊",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "How can i help you today  ? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppConstants.appColor,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SendPrompt(textController: controller , selectedImg: selectedimg , sendMessage: sendMessage,)
            ),
          ),
        ],
      ),
    ) ;
  }
}