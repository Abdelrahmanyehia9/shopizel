import 'dart:io';

class Message {
  final String text;
  final bool isBot;
  final String time;
  final File? img ;

  Message({required this.text, required this.isBot, required this.time ,this.img});
}