import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Auth/view/widgets/auth_textfeild.dart';
import 'package:shoppizel/Features/Machine/robot/controller/clothes_measure_cubit.dart';
import 'package:shoppizel/Features/Machine/robot/controller/clothes_measure_state.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../../../core/function/snackbars.dart';
import '../screen/measure_screen.dart';

class MeasureInfoScreen extends StatefulWidget {
  final String imgModel ;
  const MeasureInfoScreen({super.key ,required this.imgModel});

  @override
  State<MeasureInfoScreen> createState() => _MeasureInfoScreenState();
}

class _MeasureInfoScreenState extends State<MeasureInfoScreen> {
  int? _nCurrentValue  ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("measurement"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network("https://reviewed-com-res.cloudinary.com/image/fetch/s--uSl9InHH--/b_white,c_limit,cs_srgb,f_auto,fl_progressive.strip_profile,g_center,q_auto,w_972/https://reviewed-production.s3.amazonaws.com/1574349790361/tape.jpg")
            ,const SizedBox(height: 8,)
          ,const Text("Height"  ,style: TextStyle(fontWeight: FontWeight.bold),) ,
            WheelSlider.number(
              enableAnimation: true,
              background: Container(width: double.infinity,
              color: AppConstants.appColor.withOpacity(0.1),height: 40,),
              perspective: 0.007,
              totalCount: 200,
              initValue: 170,
              selectedNumberStyle: const TextStyle(fontWeight: FontWeight.bold , color: AppConstants.appColor , fontSize: 16),
              unSelectedNumberStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
              currentIndex: _nCurrentValue,
              onValueChanged: (val) {
                setState(() {
                  _nCurrentValue = val;
                });
              },
              hapticFeedbackType: HapticFeedbackType.vibrate,
            ),
          const SizedBox(height: 12,) , 
          const Text("Gender"  ,style: TextStyle(fontWeight: FontWeight.bold),) ,
            const Padding(
      padding: EdgeInsets.symmetric(vertical:  8.0),
      child: GenderSelection(),
    ) ,
            const Spacer(),
            BlocConsumer<ClothesMeasureCubit , ClothesMeasureState>(
              listener: (context , state)async{
                if (state is ClothesMeasureStateSuccess){
                  List<ProductModel>products = await BlocProvider.of<ClothesMeasureCubit>(context).repo.getMeasureProduct(state.measureModel.sizeValue) ;
Navigator.push(context, MaterialPageRoute(builder: (_)=>MeasureScreen(imgModel: widget.imgModel  , model: state.measureModel, products: products,))) ;

                }else if (state is ClothesMeasureStateFailure){
                  SnackBars.customSnackBar(context: context, desc: state.errorMessage, tittle: "error", type: AnimatedSnackBarType.error) ;
                }
              },
              builder:(context , state) {
                if(state is ClothesMeasureStateLoading){
                  return const Center(child: CircularProgressIndicator(),) ;
                }
                return PrimaryButton(label: "Get Size" , onTap: (){
                BlocProvider.of<ClothesMeasureCubit>(context).getMeasure(img: widget.imgModel, height: double.parse(_nCurrentValue.toString()) );
              },);
              },
            )
            
        ],),
      ),
    );
  }
}
class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          minVerticalPadding: 0,
          minTileHeight: 12,
          contentPadding: EdgeInsets.zero,
          title: const Text('Male'),
          leading: Radio<String>(
            fillColor: WidgetStateProperty.all(AppConstants.appColor),

            value: 'Male',
            groupValue: _selectedGender,
            onChanged: (String? value) {
              setState(() {
                _selectedGender = value;
              });
            },
          ),
        ),
        ListTile(
          minTileHeight: 12,
          minVerticalPadding: 2,
          contentPadding: EdgeInsets.zero,
          title: const Text('Female'),
          leading: Radio<String>(
            fillColor: WidgetStateProperty.all(AppConstants.appColor),
            value: 'Female',
            groupValue: _selectedGender,
            onChanged: (String? value) {
              setState(() {
                _selectedGender = value;
              });
            },
          ),
        ),
        ListTile(
          minTileHeight: 12,
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          title: const Text('Other'),
          leading: Radio<String>(
            fillColor: WidgetStateProperty.all(AppConstants.appColor),
            value: 'Other',
            groupValue: _selectedGender,
            onChanged: (String? value) {
              setState(() {
                _selectedGender = value;
              });
            },
          ),
        ),
      ],
    );
  }
}