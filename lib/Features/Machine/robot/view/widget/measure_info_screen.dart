import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Machine/robot/controller/clothes_measure_cubit.dart';
import 'package:shoppizel/Features/Machine/robot/controller/clothes_measure_state.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/function/predict_size.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import 'package:wheel_slider/wheel_slider.dart';
import '../../../../../core/widgets/snackbars.dart';
import '../screen/measure_screen.dart';

class MeasureInfoScreen extends StatefulWidget {
  final String imgModel;

  const MeasureInfoScreen({super.key, required this.imgModel});

  @override
  State<MeasureInfoScreen> createState() => _MeasureInfoScreenState();
}

class _MeasureInfoScreenState extends State<MeasureInfoScreen> {
  String? selectedGender;
  int? _nCurrentValue;
  int? _nCurrentValueWeight ;
  bool error = false ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("measurement"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
                "https://reviewed-com-res.cloudinary.com/image/fetch/s--uSl9InHH--/b_white,c_limit,cs_srgb,f_auto,fl_progressive.strip_profile,g_center,q_auto,w_972/https://reviewed-production.s3.amazonaws.com/1574349790361/tape.jpg"),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Height",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            WheelSlider.number(
              enableAnimation: true,
              background: Container(
                width: double.infinity,
                color: AppConstants.appColor.withOpacity(0.1),
                height: 40,
              ),
              perspective: 0.007,
              totalCount: 200,
              initValue: 170,
              selectedNumberStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.appColor,
                  fontSize: 16),
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
            const Text(
              "Weight",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            WheelSlider.number(
              enableAnimation: true,
              background: Container(
                width: double.infinity,
                color: AppConstants.appColor.withOpacity(0.1),
                height: 40,
              ),
              perspective: 0.007,
              totalCount: 150,
              initValue: 70,
              selectedNumberStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.appColor,
                  fontSize: 16),
              unSelectedNumberStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
              currentIndex:_nCurrentValueWeight,
              onValueChanged: (val) {
                setState(() {
                  _nCurrentValueWeight = val;
                });
              },
              hapticFeedbackType: HapticFeedbackType.vibrate,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Gender",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GenderSelection(
                selectedGender: (value) {
                  selectedGender = value;
                },
              ),
            ),
            error == true ? const Text("please choose your gender " , style: TextStyle(color: Colors.red) ): SizedBox() ,
            const Spacer(),
            BlocConsumer<ClothesMeasureCubit, ClothesMeasureState>(
              listener: (context, state) async {
                if (state is ClothesMeasureStateSuccess) {
                  print(predictSize(height: _nCurrentValue?.toDouble()??170, weight: _nCurrentValueWeight?.toDouble()??70, model: state.measureModel)) ;

                  List<ProductModel> products =  await BlocProvider.of<ClothesMeasureCubit>(context)
                          .repo
                          .getMeasureProduct(size : state.measureModel.sizeValue  , gender:  selectedGender == "Other" ? null : selectedGender);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MeasureScreen(
                            size:  predictSize(height: _nCurrentValue?.toDouble()??170, weight:_nCurrentValueWeight?.toDouble()??70 , model: state.measureModel),
                                imgModel: widget.imgModel,
                                model: state.measureModel,
                                products: products,
                              )));
                } else if (state is ClothesMeasureStateFailure) {
                  SnackBars.customSnackBar(
                      context: context,
                      desc: state.errorMessage,
                      tittle: "error",
                      type: AnimatedSnackBarType.error);
                }
              },
              builder: (context, state) {
                if (state is ClothesMeasureStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return PrimaryButton(
                  label: "Get Size",
                  onTap: () {
                    if (selectedGender == null ){
                      setState(() {
                        error = true ;
                      });
                    }else{
                      BlocProvider.of<ClothesMeasureCubit>(context).getMeasure(img: widget.imgModel , height: _nCurrentValue?.toDouble()??170);




                    }

                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class GenderSelection extends StatefulWidget {
  final void Function(String?) selectedGender;

  const GenderSelection({super.key, required this.selectedGender});

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
            value: 'Men',
            groupValue: _selectedGender,
            onChanged: (String? value) {
              setState(() {
                _selectedGender = value;
              });
              widget.selectedGender(_selectedGender) ;
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
            value: 'Women',
            groupValue: _selectedGender,
            onChanged: (String? value) {
              setState(() {
                _selectedGender = value;
              });
              widget.selectedGender(_selectedGender) ;

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
              widget.selectedGender(_selectedGender) ;

            },
          ),
        ),
      ],
    );
  }
}
