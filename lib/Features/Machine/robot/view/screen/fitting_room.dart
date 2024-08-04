import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoppizel/Features/Machine/robot/controller/fitting_room_cubit.dart';
import 'package:shoppizel/Features/Machine/robot/data/repo/fitting_room_repo.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/service/ImageHelper.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/service/pick_image.dart';
import '../widget/fit_model.dart';
import '../widget/measure_info_screen.dart';

class FittingRoom extends StatefulWidget {
  final bool? isMeasure ;
  const FittingRoom({super.key , this.isMeasure});

  @override
  State<FittingRoom> createState() => _FittingRoomState();
}

class _FittingRoomState extends State<FittingRoom> {
  File? _selectedImg;
  bool isLoading = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.isMeasure ==true ? "Measurements":"Fitting Room"),
      ),
      body: _selectedImg == null
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Upload Your Photo ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.appColor),
            ),
            const SizedBox(
              height: 4,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "To get best result upload photo with high quality and standing normal poses, make sure show your body clear",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                refusedItem(false, context, "assets/images/accepted.jpg"),
                refusedItem(true, context, "assets/images/ref1.jpg"),
                refusedItem(true, context, "assets/images/ref3.jpg"),
                refusedItem(true, context, "assets/images/re2.jpg"),
              ],
            ),
            const Spacer(),
            PrimaryButton(
              label: "upload Image",
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => ChooseImagePicker(
                        isSearching: true,
                        onSelected: (value) {
                          setState(() {
                            _selectedImg = value;
                          });
                        }));
              },
            ),
            const SizedBox(
              height: 8,
            ),
            PrimaryButton(
              label: "later",
              color: Colors.white,
              onTap: () {
                Navigator.pop(context) ;
              },
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      )
          : ModalProgressHUD(
        inAsyncCall: isLoading,
            child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Do you Want To use This Picture ? ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                  width: screenWidth(context) * .7,
                  child: Text(
                    "Press submit to confirm, back to upload new photo",
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade600),
                  )),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                    height: screenHeight(context) * .48,
                    width: screenWidth(context),
                    child: Image.file(
                      _selectedImg!,
                      fit: BoxFit.cover,
                    )),
              ),
              const Spacer(),
              PrimaryButton(
                label: "Submit",
                onTap: () async {
                  setState(() {
                    isLoading = true ;
                  });
                    FittingRoomRepo repo = BlocProvider.of<FittingRoomCubit>(context).repo ;
                  List<ProductModel> items = await repo.getTopProducts() ;
                  String? imgModel = await ImageHelper.uploadImage(image: _selectedImg!) ;
print(imgModel) ;
                 Navigator.push(context, MaterialPageRoute(builder: (_) => widget.isMeasure == true ?  MeasureInfoScreen(imgModel : imgModel) : FitModel(imgModel: imgModel!, products : items)));
                  setState(() {
                    isLoading = false ;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              PrimaryButton(
                onTap: () {
                  setState(() {
                    _selectedImg = null;
                  });
                },
                label: "Back",
                color: Colors.white,
              ),
            ],
                    ),
                  ),
          ),
    );
  }

  Widget refusedItem(bool? refused, BuildContext context, String imgPath) =>
      Column(
        children: [
          Container(
            width: screenWidth(context) * 0.215,
            height: screenHeight(context) * 0.22,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(imgPath), fit: BoxFit.fitHeight),
                border: Border.all(
                    color: refused == false ? Colors.green : Colors.red,
                    width: 2)),
          ),
          const SizedBox(
            height: 4,
          ),
          Icon(
            refused == false ? FontAwesomeIcons.check : FontAwesomeIcons.close,
            color: refused == false ? Colors.green : Colors.red,
            size: 24,
          ),
        ],
      );
}