
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/Machine/robot/view/screen/chatbot_screen.dart';
import 'package:shoppizel/Features/Machine/robot/view/screen/fitting_room.dart';
import 'package:shoppizel/Features/Machine/robot/view/screen/generate_outfit.dart';
import 'package:shoppizel/Features/Machine/robot/view/widget/chat_over_view.dart';
import 'package:shoppizel/core/utils/app_constants.dart';


class RobotScreen extends StatelessWidget {
  const RobotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                robotItem(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const GenerateOutfit()));

                  },
                    color: AppConstants.appColor,
                    tittle: "Generate Outfit",
                    disc: "get outfit good with her",
                    imgUrl:
                        "https://img.freepik.com/premium-photo/chinese-gentleman-dressed-corporate-outfit-generate-ai_98402-102866.jpg"),
                robotItem(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const FittingRoom()));
                    },
                    color: Colors.red,
                    tittle: "Fitting Room ",
                    disc: "see outfits on your image",
                    imgUrl:
                        "https://cdn.paautism.org/uploads/2019/07/ClothesShopping-1000x450.jpg"),
                robotItem(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) =>  const FittingRoom(isMeasure:true)));
                    },
                    color: Colors.yellow.shade900,
                    tittle: "Measurements",
                    disc: "know your size instantly",
                    imgUrl:
                        "https://www.threekit.com/hs-fs/hubfs/Measuring%20the%20fit%20of%20a%20suit%20along%20the%20wearers%20back.jpg?width=855&name=Measuring%20the%20fit%20of%20a%20suit%20along%20the%20wearers%20back.jpg"),
                robotItem(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const ChatBotOverview())) ;
                  },
                    color: Colors.blue,
                    tittle: "Chat Ai",
                    disc: " Chat bot as you want",
                    imgUrl:
                        "https://d2vrvpw63099lz.cloudfront.net/do-i-need-a-chatbot/header-chat-box.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget robotItem(
          {required String tittle,
          required String disc,
          required String imgUrl,
          required Color color,
          GestureTapCallback? onTap}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(.6), BlendMode.xor)),
                borderRadius: BorderRadius.circular(8),
                color: color),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tittle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    disc,
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}



