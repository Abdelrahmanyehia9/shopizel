import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  _SupportChatScreenState createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  bool _areButtonsVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat us'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _areButtonsVisible,
        opacity: 0.5,
        progressIndicator: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                fixedSize: Size(screenWidth(context)*.6, 50)
              ),
              onPressed: () {
                setState(() {
                  _areButtonsVisible = false;
                });
              },
              child: Text('New Ticket'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                overlayColor: Colors.white,
           elevation: 0,
           backgroundColor: Colors.orange.shade900,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  fixedSize: Size(screenWidth(context)*.6, 50)
              ),
              onPressed: () {

              },
              child: Text('Existing ticket'),
            ),
          ],
        ),
        child: Center(
          child: _areButtonsVisible ? const SizedBox.shrink() : const Text('Main Page Chat'),
        ),
      ),
    );
  }
}