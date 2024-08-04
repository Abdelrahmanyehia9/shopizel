import 'package:flutter/material.dart';
import 'package:shoppizel/Features/Machine/robot/data/model/clothes_measure_model.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_gallery.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../../../home/data/model/product_model.dart';
import '../widget/size_measure_contaainer.dart';

class MeasureScreen extends StatefulWidget {
  final String imgModel ;
  final ClothesMeasureModel model ;
  final List<ProductModel> products ;
  final String size ;
  const MeasureScreen({super.key , required this.imgModel , required this.model , required this.products , required this.size});

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
                  const Row(
                    children: [
                      Text("width:  " , style: TextStyle(color: Colors.red   , fontSize: 12  , fontWeight: FontWeight.bold),),
                      Expanded(child: Text("distance between left shoulder and right shoulder" , style: TextStyle(color: Colors.grey  , fontSize: 12),))
                    ],
                  ),
                  const Row(
                    children: [
                      Text("Height:  " , style: TextStyle(color: Colors.blue   , fontSize: 12  , fontWeight: FontWeight.bold),),
                      Expanded(child: Text("distance between shoulder and bottom of shirt" , style: TextStyle(color: Colors.grey  , fontSize: 12),))
                    ],
                  ) ,
                  const Row(
                    children: [
                      Text("Sleeve:  " , style: TextStyle(color: Colors.green   , fontSize: 12  , fontWeight: FontWeight.bold),),
                      Expanded(child: Text("the long of sleeve " , style: TextStyle(color: Colors.grey  , fontSize: 12),))
                    ],
                  ) ,
                  const SizedBox(height: 8,) ,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(onPressed: (){
                        _controller.hideTooltip() ;
                      }, style: TextButton.styleFrom(foregroundColor: AppConstants.appColor
                      ), child: const Text("I understood") ,),
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
                SizeMeasureContainer(imgModel: widget.imgModel , model:  widget.model, size : widget.size) ,
              const SizedBox(height: 12,)  ,
              ProductGallery(color: AppConstants.appColor.value.toString(), collection: widget.products)
            ]
          ),
        ),
      )
    );
  }
}
