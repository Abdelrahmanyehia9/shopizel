import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/screen_dimentions.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_container.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/formfeild_label.dart';


class ConfirmOtp extends StatelessWidget {
   ConfirmOtp({super.key, required this.email});
  final String email  ;
  TextEditingController otpController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: screenHeight(context),
              width: screenWidth(context),
            ),
            AuthContainer(
              tittle: "Verification",
              subTittle: "We have sent a code to your email",
              emailIfOtpPage: email,
            ),
            AuthFormContainer(
              form: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const FormfeildLabel(
                        label: "Code",
                      ),

                      SizedBox(width: screenWidth(context)*0.8,
                        child: PinCodeTextField(

                          appContext: context,
                          length: 4,
                          controller: otpController,
                          animationType: AnimationType.scale,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeFillColor: Colors.grey.shade200,
                            selectedFillColor: Colors.grey.shade200,
                            inactiveFillColor: Colors.grey.shade200,
                            activeColor: Colors.grey.shade200,
                            selectedColor: Colors.orange,
                            inactiveColor: Colors.grey.shade200,
                          ),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      PrimaryButton(
                        label: "Verify",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

}
