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
                    name: "SATIN FLORAL PRINT SHIRT",
                    desc: "Collared shirt with long sleeves. Front button fastening.",
                    imageCover: "https://static.zara.net/assets/public/3235/9a17/88964e60ae4e/f6c5a62546b2/02378109330-p/02378109330-p.jpg?ts=1706799628793&w=750",
                    images: ["https://static.zara.net/assets/public/926e/898e/54cf47b3a1fe/e72013059e62/02378109330-a2/02378109330-a2.jpg?ts=1706799634593&w=750" ,
                    "https://static.zara.net/assets/public/e312/1320/200b40728f63/092d78cde0ea/02378109330-a4/02378109330-a4.jpg?ts=1706799632663&w=750" ,
                    "https://static.zara.net/assets/public/5902/18d5/86f54719a3cc/81471c2a07ca/02378109330-e1/02378109330-e1.jpg?ts=1706798733263&w=750"],
                    sizes: ["Xs" ,"S" , "M" , "L" , "XL" , "XXL" ],
                    colors: [
                    "0xFF1976D2"],
                    madeBy: "Zara",
                    rate: "4.3",
                    count: "13",
                    price: "6400",
                    category: "Women",
                    sale: "30",
                     type: 't-shirt' ,
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
