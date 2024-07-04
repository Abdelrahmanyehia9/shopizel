import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:shoppizel/Features/home/view/widgets/home/select_location.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 18.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text("Shipping address" , style: TextStyle(fontSize: 18 , color: AppConstants.appColor),),
              //       Text("(long tap To change) "  , style: TextStyle( color: Colors.grey),)
              //     ],
              //   ),
              // ) ,
              InkWell(
                  onLongPress: () {
                    ///select a location
                  },
                  child: const ShippingAddress()),
              const DeliveryTime(),
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  "Shopping Cart",
                  style: TextStyle(fontSize: 18, color: AppConstants.appColor),
                ),
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) => OrderProducts()),
              Divider(
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  "Have a Gift Cart",
                  style: TextStyle(fontSize: 18, color: AppConstants.appColor , fontWeight: FontWeight.bold),
                ),

              ),
              GiftCartTextField() ,
              SizedBox(height: 16,) ,
              OrderFees() ,
              CheckoutButton()


            ],
          ),
        ),
      ),
    );
  }
}

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return savedLocationItem(context: context);
  }

  Widget savedLocationItem(
          {required BuildContext context, GestureTapCallback? onRemove}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              width: screenWidth(context),
              height: screenHeight(context) * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: screenWidth(context),
                      height: screenHeight(context) * 0.25,
                      child: FlutterMap(
                        options: MapOptions(
                            keepAlive: true,
                            initialCenter: LatLng(
                              double.parse("29.012501"),
                              double.parse("30.52012"),
                            ),
                            initialZoom: 18.0,
                            interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.none)),
                        children: [
                          TileLayer(
                              urlTemplate:
                                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app'),
                          AnimatedLocationMarkerLayer(
                              moveAnimationDuration:
                                  const Duration(milliseconds: 300),
                              style: const LocationMarkerStyle(
                                  markerSize: Size.square(40),
                                  showAccuracyCircle: false,
                                  showHeadingSector: false,
                                  marker: Icon(
                                    Icons.location_on,
                                    color: AppConstants.appColor,
                                    size: 40,
                                  )),
                              position: LocationMarkerPosition(
                                  latitude: 29.952654,
                                  longitude: 30.921919,
                                  accuracy: 0.0)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "model.name",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "model.tittle,",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Building: 5  Floor: 5    Flat No: 2",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "01501634466",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class OrderProducts extends StatefulWidget {
  const OrderProducts({super.key});

  @override
  State<OrderProducts> createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight(context) * .25,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: screenWidth(context) * .3,
                      height: screenHeight(context) * .2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://www.next.mx/nxtcms/resource/blob/5791586/ee0fc6a294be647924fa5f5e7e3df8e9/hoodies-data.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth(context) * 0.4,
                          child: Text(
                            " widget.model.name,",
                            maxLines: 2,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Size : size",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          "quantity: 5",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Color :",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 6,
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                  text: "40" != "0"
                                      ? (double.parse("1000") *
                                              1 *
                                              (0.99999 -
                                                  double.parse("50") / 100.0))
                                          .toStringAsFixed(2)
                                          .split(".")
                                          .first
                                      : (double.parse("1000") * 1)
                                          .toStringAsFixed(0),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                    color: AppConstants.appColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          ".${(double.parse("1000") * 1 * (0.99999 - double.parse("40") / 100.0)).toStringAsFixed(2).split(".").last}",
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    const TextSpan(
                                      text: " EGP",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    TextSpan(
                                      text: "50" != "0"
                                          ? " ${double.parse("1000") * 1}EGP"
                                          : "",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 9,
                                          decorationColor: Colors.grey),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  ///add quantity
                                });
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: const FaIcon(
                                    FontAwesomeIcons.plus,
                                    size: 14,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("2"),
                            ),
                            InkWell(
                              onTap: () async {
                                ///reduce quantity
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: const FaIcon(
                                    FontAwesomeIcons.minus,
                                    size: 14,
                                  )),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: InkWell(
                /// remove Item
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Text(
                    "Remove",
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class DeliveryTime extends StatelessWidget {
  const DeliveryTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: screenHeight(context) * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: AppConstants.gradient),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.delivery_dining,
                    color: Colors.white,
                  ),
                  Text(
                    "Delivery",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                "Arrive in 20 Minutes",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GiftCartTextField extends StatelessWidget {
  const GiftCartTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        SizedBox(width: screenWidth(context)*.7,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 12),
            child: TextField(

              decoration: InputDecoration(
                hintText : "apply here" ,
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,

                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: screenWidth(context)*0.25,
          padding: EdgeInsets.symmetric(vertical: 18 ,),
          child: Text("Apply", style: TextStyle(color: Colors.white),),
          decoration: BoxDecoration(
            gradient: AppConstants.gradient,
            borderRadius: BorderRadius.circular(4) ,
          ),
        )

      ],
    );
  }
}

class OrderFees extends StatelessWidget {
  const OrderFees({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
              feesItem(tittle: "Order" , value: "1200" , isSale: true),
        feesItem(tittle: "shipping" , value: "20"),
        feesItem(tittle: "service" , value: "4.5"),
        feesItem(tittle: "discount" , value: "120"),
        feesItem(tittle: "Gift Card " , value: "40" , isPromo: true),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Divider(color: Colors.grey,),
        ) ,
feesItem(tittle: "Total", value: "1150")


      ],
    );
  }


  Widget feesItem({required String tittle, required value , bool? isPromo , bool? isSale }){

    return Padding(
      padding: const EdgeInsets.only(top: 2.0 , right: 18 , left: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tittle , style: TextStyle (fontSize: 16 , color: isPromo!=null ? Colors.green : Colors.black ,
             ),) ,
          Text(value+" EGP" , style: TextStyle(fontSize: 14 ,   decoration: isSale != null ? TextDecoration.lineThrough:TextDecoration.none),)

        ],
      ),
    ) ;

  }
}
class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return               Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: AppConstants.gradient,                    borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Checkout",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),
            Row(
              children: [
                Text(
                  "1150 EGP",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    ) ;

  }
}

