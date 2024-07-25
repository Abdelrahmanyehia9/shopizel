import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import '../../../../core/service/image_picker.dart';

class ChooseImagePicker extends StatefulWidget {
  final GestureTapCallback? onRemove ;
  final void Function(File?) onSelected ;
 final bool? isSearching ;
  const ChooseImagePicker({super.key , required this.onSelected , this.onRemove , this.isSearching});

  @override
  State<ChooseImagePicker> createState() => _ChooseImagePickerState();
}

class _ChooseImagePickerState extends State<ChooseImagePicker> {
  File? _imageFile;
  final ImagePickerService _imagePickerService = ImagePickerService();

  Future<void> _pickImage(ImageSource source) async {
    File? pickedFile = await _imagePickerService.pickImage(source);
    if (!mounted) return;

    setState(() {
      _imageFile = pickedFile;
    });

    if (_imageFile != null) {
      Navigator.pop(context);
      widget.onSelected(_imageFile!);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context) ;
                } ,
                child: CircleAvatar(
                  backgroundColor: Colors.teal.withOpacity(0.095),
                  child: const Icon(Icons.close , color: AppConstants.appColor,),
                ),
              ),
            ),
          ) ,
          ElevatedButton.icon(
            onPressed: () {
              _pickImage(ImageSource.camera);
            },
            label: const Text(
              "Camera",
              style: TextStyle(fontSize: 18),
            ),
            icon: const Icon(Icons.camera),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth(context), 60),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          ElevatedButton.icon(
            onPressed: () {
              _pickImage(ImageSource.gallery);
            },
            label: const Text(
              "Gallery",
              style: TextStyle(fontSize: 18),
            ),
            icon: const Icon(Icons.photo_library),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth(context), 60),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        widget.isSearching ==true ?const SizedBox():  ElevatedButton.icon(
            onPressed: widget.onRemove ,
            label: const Text(
              "Delete",
              style: TextStyle(fontSize: 18),
            ),
            icon: const Icon(Icons.delete),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth(context), 60),
              backgroundColor: Colors.red.shade800 ,
              overlayColor: Colors.red.shade100
            ),
          ),
        ],
      ),
    );
  }
}
