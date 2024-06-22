import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: AppConstants.btnColor,),);
  }
}
