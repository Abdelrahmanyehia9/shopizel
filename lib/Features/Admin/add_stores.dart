import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/data/model/store_model.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

class AddStores extends StatelessWidget {
  AddStores({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController imagecover = TextEditingController();
  final TextEditingController images = TextEditingController();
  final TextEditingController count = TextEditingController();
  final TextEditingController fees = TextEditingController();
  final TextEditingController time = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250,) ,
            Center(
              child: ElevatedButton(onPressed: () async {
                ProductModel model = ProductModel(
                    id: 15,
                    name: "EXTRA HEAVY WEIGHT T-SHIRT",
                    desc: "Loose-fitting T-shirt made of compact, heavy cotton fabric. Featuring a round neck and short sleeves.",
                    imageCover: "https://static.zara.net/assets/public/769a/bdbe/e5714fddb6a9/6db4a4fe4e29/04092414716-e1/04092414716-e1.jpg?ts=1714477466716&w=750",
                    images: ["https://static.zara.net/assets/public/7e9c/846b/038645a1ab3e/78e72d1f84e5/04092414716-p/04092414716-p.jpg?ts=1714643814390&w=750" ,
                      "https://static.zara.net/assets/public/2285/83e2/f55043a2beb6/a50b09fc5da3/04092414716-a1/04092414716-a1.jpg?ts=1714643816234&w=750" ,
                      "https://static.zara.net/assets/public/1c75/72ff/d438406ab2fe/f4e1ed02752c/04092414716-a4/04092414716-a4.jpg?ts=1714643813913&w=750" ,
                      "https://static.zara.net/assets/public/8651/561f/12594e4a8fd2/c23cedc30923/04092414716-a2/04092414716-a2.jpg?ts=1714643816701&w=750"
                    ],
                    sizes: [ "S" , "M" , "L"  , "XL","XXL" ],
                    colors: [
                      "0xff512c06" ,
                      "0xfffff2cc"

                    ],
                    madeBy: "Zara",
                    rate: "2.4",
                    count: "420",
                    price: "2190",
                    category: "Men",
                    sale: "0" ,
                    type: 't-shirt' ,
                    dateTime: DateTime.now().toString()
                ) ;
                FirebaseFirestore firebase = FirebaseFirestore.instance;
                await firebase.collection(FirebaseConstant.productsCollections).add(
                    model.toJson());
              }, child: const Text("ADD")),
            ),
          ],
        ),
      ),


    );
  }

  Widget customField (String label , TextEditingController controller){

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal)
        )
      ),
    );
  }
}
