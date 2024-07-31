
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../profile/view/screen/pick_image.dart';

class SendPrompt extends StatefulWidget {
  final TextEditingController textController ;
  final GestureTapCallback sendMessage ;
  final void Function(File?)selectedImg;
  File? img  ;
   SendPrompt({super.key , required this.textController  , required this.sendMessage  , required this.selectedImg , this.img});

  @override
  State<SendPrompt> createState() => _SendPromptState();
}

class _SendPromptState extends State<SendPrompt> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: widget.textController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Type message',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        if (widget.img == null) IconButton(
          icon: const Icon(Icons.photo , color: Colors.white,),
          onPressed: (){
            showModalBottomSheet(context: context, builder: (_)=>ChooseImagePicker(isSearching:true , onSelected: (value){
              setState(() {
                widget.img = value ;
              });
              widget.selectedImg(widget.img);
            }) ) ;
          },
        ) else InkWell(
          onTap: (){
            setState(() {
              widget.img = null ;
            });
            widget.selectedImg(null) ;
          },
          child: Stack(
            alignment: AlignmentDirectional.center ,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(height: screenHeight(context)*.065 , width: screenWidth(context)*.1, child: Image.file(widget.img! , fit: BoxFit.fill,),),
              ),
              const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 12,
                  child: Icon( Icons.delete , size: 10, color: Colors.white,))
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send , color: Colors.white,),
          onPressed: widget.sendMessage,
        ),

      ],
    ) ;
  }

}