import 'package:flutter/material.dart';

import '../../../../../core/utils/app_constants.dart';

class MessageBubbleLoading extends StatelessWidget {
  const MessageBubbleLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
        MainAxisAlignment.start  ,
        children: <Widget>[

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppConstants.appColor,
              backgroundImage: AssetImage("assets/images/robot-friendly-chatbot-with-antenna-message-chat-vector-40420716-removebg-preview.png"),
            ),
          ),

          Flexible(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: const BoxDecoration(
                  color:  Colors.white  ,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10) , bottomRight: Radius.circular( 10) , bottomLeft: Radius.circular(0)),
                ),
                child: LinearProgressIndicator(color: AppConstants.appColor,)
            ),
          ),

        ],
      ),
    );
  }
}
