import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

Future<bool> onWillPop(BuildContext context , String desc) async {
  final shouldPop = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content:  Text(desc),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppConstants.appColor),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppConstants.appColor),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
  return shouldPop ?? false;
}
