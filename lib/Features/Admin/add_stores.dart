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
                ProductModel model = ProductModel(id: 1,
                    name: "LCW Kids Crew Neck Short Sleeve Girl's Dress",
                    desc: "Above Knee Pattern dress with cotton 100%",
                    imageCover: "https://img-lcwaikiki.mncdn.com/mnresize/1020/1360/pim/productimages/20241/6936652/v1/l_20241-s4bn58z4-fkw_a3.jpg",
                    images: ["https://img-lcwaikiki.mncdn.com/mnresize/1020/1360/pim/productimages/20241/6936652/v1/l_20241-s4bn58z4-fkw_a1.jpg" ,
                    "https://img-lcwaikiki.mncdn.com/mnresize/1020/1360/pim/productimages/20241/6936652/v1/l_20241-s4bn58z4-fkw_a3.jpg" ,
                  ],
                    sizes: ["4" ,"5" , "6" , "7" , ],
                    colors: [
                    "0xffe1c4ff"
                    ],
                    madeBy: "Lc Waikiki",
                    rate: "2.5",
                    count: "100",
                    price: "1000",
                    category: "Kids",
                    sale: "50" ,
                     type: 'kids' ,
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
