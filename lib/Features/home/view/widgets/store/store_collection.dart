import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_item.dart';
import 'package:shoppizel/core/widgets/see_all.dart';
import '../../../../../core/widgets/offer_card.dart';

class StoreCollection extends StatelessWidget {
  const StoreCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          offerCard3("https://ua-retail.com/wp-content/uploads/2016/07/Ouverture-du-premier-magasin-LC-WAIKIKI-en-Tunisie-02.jpg"),

          const SizedBox(height: 12,) ,
      const SeeAll(tittle: "Categories") ,
          const SizedBox(height: 10,) ,
          SizedBox(height: 120,
            child: ListView(

              scrollDirection: Axis.horizontal,
              children: [
                clothCat() ,
                clothCat() ,
                clothCat() ,
                clothCat() ,
                clothCat() ,

              ],

            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: SeeAll(tittle: "Popular"),
          ) ,
      SizedBox(
        height: 280,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            ProductItem() ,
            ProductItem() ,
            ProductItem()


          ],
        ),
      ) ,

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: offerCard2(),
          ) ,
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SeeAll(tittle: "Sale"),
          ) ,
          SizedBox(
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                ProductItem() ,
                ProductItem() ,
                ProductItem()


              ],
            ),
          ) ,
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SeeAll(tittle: "Popular"),
          ) ,
          SizedBox(
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                ProductItem() ,
                ProductItem() ,
                ProductItem()


              ],
            ),
          ) ,
          offerCard1(),






        ],
      ),
    );
  }

  Widget clothCat(){
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,radius: 32,
          ) ,
          Text("T-shirt" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),) ,
        ],
      ),
    );
  }
}
