import 'package:flutter/material.dart';
import 'package:shoppizel/Features/Machine/robot/data/model/clothes_measure_model.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_gallery.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../../../home/data/model/product_model.dart';

class MeasureScreen extends StatefulWidget {
  final String imgModel ;
  final ClothesMeasureModel model ;
  final List<ProductModel> products ;
  const MeasureScreen({super.key , required this.imgModel , required this.model , required this.products});

  @override
  State<MeasureScreen> createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  final _controller = SuperTooltipController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            
            onTap: () async {
              await _controller.showTooltip();
            },
            child: SuperTooltip(
              controller: _controller,
              arrowTipDistance: 1,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      child: Image.asset("assets/images/size-chart.png")) ,
                  Row(
                    children: [
                      Text("width:  " , style: TextStyle(color: Colors.red   , fontSize: 12  , fontWeight: FontWeight.bold),),
                      Expanded(child: Text("distance between left shoulder and right shoulder" , style: TextStyle(color: Colors.grey  , fontSize: 12),))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Height:  " , style: TextStyle(color: Colors.blue   , fontSize: 12  , fontWeight: FontWeight.bold),),
                      Expanded(child: Text("distance between shoulder and bottom of shirt" , style: TextStyle(color: Colors.grey  , fontSize: 12),))
                    ],
                  ) ,
                  Row(
                    children: [
                      Text("Sleeve:  " , style: TextStyle(color: Colors.green   , fontSize: 12  , fontWeight: FontWeight.bold),),
                      Expanded(child: Text("the long of sleeve " , style: TextStyle(color: Colors.grey  , fontSize: 12),))
                    ],
                  ) ,
                  SizedBox(height: 8,) ,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(onPressed: (){
                        _controller.hideTooltip() ;
                      }, child: Text("I understood") , style: TextButton.styleFrom(foregroundColor: AppConstants.appColor
                      ),),
                    ),
                  ) ,


                ],
              ),
              child: const Icon(Icons.info)
            ),
          ),
          const SizedBox(width: 12),
        ],
        title: const Text("Measurement"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children:[
                SizeMeasureContainer(imgModel: widget.imgModel , model:  widget.model,) ,
              const SizedBox(height: 12,) ,
              ProductGallery(color: AppConstants.appColor.value.toString(), collection: widget.products)
            ]
          ),
        ),
      )
    );
  }
}
class SizeMeasureContainer extends StatelessWidget {
  final String imgModel ;
  final ClothesMeasureModel model  ;
  const SizeMeasureContainer({super.key , required this.imgModel , required this.model});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(8),
      height: screenHeight(context) * .3,
      width: screenWidth(context),
      decoration: BoxDecoration(
        color: AppConstants.appColor,
        boxShadow: AppConstants.shadow ,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            height: screenHeight(context) * .3,
            width: screenWidth(context) * .35,
            child: ClipRRect(borderRadius: BorderRadius.circular(8),
                child: Image.network(imgModel, fit: BoxFit.cover)),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeItem(context , "Width"  , model.chestWidth.toStringAsFixed(0)),
              sizeItem(context , "Height"  , model.frontLength.toStringAsFixed(0)),
              sizeItem(context , "Sleeve"  , model.sleeveLength.toStringAsFixed(0)),
              sizeItem(context , "Size"  , model.sizeValue)


            ],
          ),
        ],
      ),
    )
    ;
  }
  Widget sizeItem(context ,String tittle   , String value)=>Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            tittle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12,) ,
          Text(
            tittle=="Size"? value: "${value}cm",
            style:  TextStyle(
              fontSize: 12,
              color: tittle == "Size" ? Colors.yellow :Colors.grey,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Container(
        width: screenWidth(context) * .5,
        child: const Divider(
          color: Colors.grey, // or any color you prefer
          thickness: 1,
        ),
      ),
    ],
  )  ;

}
