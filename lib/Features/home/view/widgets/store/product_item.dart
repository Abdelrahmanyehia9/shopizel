import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(18) ,
            color: Colors.white ,

          ),
            width: 180, height: 280,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center
              ,        children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(18) , topLeft: Radius.circular(18))
                  ,image: const DecorationImage(image: NetworkImage("https://cdn.suitdirect.co.uk/upload/siteimages/medium/ar24141mj_021_b.jpg" )  , fit: BoxFit.fill)
                  ),

                  height: 220, width: 180,
                ) ,
                const SizedBox(height: 12,) ,
                const Text("Cloud Blue Slim Suit" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14),) ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Row(children: [
                  Icon(Icons.star , color:  Colors.yellow.shade700, size: 14,) ,
                  Icon(Icons.star , color:  Colors.yellow.shade700, size: 14,) ,
                  Icon(Icons.star , color:  Colors.yellow.shade700, size: 14,) ,
                  Icon(Icons.star , color:  Colors.yellow.shade700, size: 14,) ,
                ],) ,
                    Text.rich(
                        TextSpan(

                          text: "45\$  "  , style: TextStyle(color: Colors.black38 , decoration: TextDecoration.lineThrough , fontSize: 12),
                        children: [
                          TextSpan(text: "30\$" , style: TextStyle(fontSize: 15 , decoration: TextDecoration.none , color: Colors.red))
                        ]
                        ) ,


                    )



                  ],
                ) ,



              ],
            ),
          ),
          Container( width: 40, height: 40,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.7) ,borderRadius:  BorderRadius.only(topLeft: Radius.circular(16) , bottomRight: Radius.circular(16) )),
          child: Center(child: Icon(Icons.favorite_border_rounded ),),

          )
        ],
      ),
    );
  }
}
