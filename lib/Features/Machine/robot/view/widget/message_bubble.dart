import 'package:flutter/material.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../data/model/message_model.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
        message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          if (message.isBot)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppConstants.appColor,
                backgroundImage: AssetImage("assets/images/robot-friendly-chatbot-with-antenna-message-chat-vector-40420716-removebg-preview.png"),
              ),
            ),

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: message.isBot ? Colors.white : AppConstants.appColor ,
                borderRadius: BorderRadius.only(topLeft: const Radius.circular(10) , topRight: const Radius.circular(10) , bottomRight: Radius.circular(message.isBot ? 10:0) , bottomLeft: Radius.circular(message.isBot?0:10)),
              ),
              child: Column(
                crossAxisAlignment: message.isBot
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: <Widget>[
                  message.img != null ? Center(
                    child: SizedBox(height: 200  , width: screenWidth(context) ,
                        child: Image.file(message.img! , fit: BoxFit.cover,)),
                  ):SizedBox()  ,
                  Text(
                    message.text,
                    style: TextStyle(fontSize: 14 , color: message.isBot ? Colors.black:Colors.white),
                  ),
                  Text(
                    message.time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          if (!message.isBot)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundColor: AppConstants.appColor,
                radius: 21.5,
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
