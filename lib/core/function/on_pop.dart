import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

Future<bool> onWillPop(BuildContext context , String desc) async {
  final shouldPop = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content:  Text(desc),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppConstants.appColor),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppConstants.appColor),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
  return shouldPop ?? false;
}
