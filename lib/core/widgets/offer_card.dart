
import 'package:flutter/material.dart';


Widget offerCard1() =>
    Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(height: 180, width: double.infinity) ,
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Summer Collections',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // Implement navigation or action
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8 ,vertical: 4),
                        decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)
                      ),
                        child: Row(
                          children: [
                            Text(
                              'See More',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container( height: 180, width: 180, child: Image.network("https://i.postimg.cc/J0Bd2WgC/young-hipster-man-with-his-arms-crossed-1368-14152-removebg-preview.png" , fit: BoxFit.cover,),
          )

      ],
    );
Widget offerCard2({required String offer}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAlias,

        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent.shade700, Colors.blueAccent.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16 , horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Special offer',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    offer,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,

                    ),


                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.alarm , color: Colors.white, ),
              )
            ],
          ),
        ),
      ),
    );
Widget offerCard3(img) =>
Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: SizedBox(height: 200 , width: double.infinity, child: Image.network(img , fit: BoxFit.cover,),),
) ;