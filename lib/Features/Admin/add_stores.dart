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
            SizedBox(height: 250,) ,
            Center(
              child: ElevatedButton(onPressed: () async {
                ProductModel model = ProductModel(id: 1,
                    name: "LCW Casual Crew Neck Short Sleeve Printed Combed Cotton Men's T-shirt",
                    imageCover: "https://img-lcwaikiki.mncdn.com/mnresize/1020/1360/pim/productimages/20241/6863011/v1/l_20241-s47378z8-t2u-98-82-95-187_a.jpg",
                    images: ["https://img-lcwaikiki.mncdn.com/mnresize/1020/1360/pim/productimages/20241/6863011/v1/l_20241-s47378z8-t2u-98-82-95-187_a.jpg" ,
                    "https://img-lcwaikiki.mncdn.com/mnresize/1020/1360/pim/productimages/20241/6863011/v1/l_20241-s47378z8-t2u-98-82-95-187_a1.jpg" ,
                    "https://img-lcwaikiki.mncdn.com/mnresize/1020/1360/pim/productimages/20241/6863011/v1/l_20241-s47378z8-t2u-98-82-95-187_a4.jpg"],
                    sizes: ["S" ,"M" , "L" , "XL"],
                    colors: ["0xffFFAC1C"],
                    madeBy: "Lc Waikiki",
                    rate: "4.2",
                    count: "1500",
                    price: "12",
                    category: "Men",
                    sale: "20" ,
                    type:  "t-shirt"
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
