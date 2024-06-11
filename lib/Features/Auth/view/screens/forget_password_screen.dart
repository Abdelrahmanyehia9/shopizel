import 'package:flutter/material.dart';
import 'package:shoppizel/Features/Auth/view/screens/confirm_otp.dart';

import '../../../../core/utils/screen_dimentions.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_container.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/auth_textfeild.dart';
import '../widgets/formfeild_label.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
        ),
        const AuthContainer(
          tittle: "Forget Password",
          subTittle: "Please sign in to your existing account",
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
                    label: "email",
                  ),
                  AuthTextField(
                    controller: emailController,
                    initialValue: "example@gmail.com",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PrimaryButton(
                    label: "Send Code",
                    onTap: () {
                      ///checking here if email is valid
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ConfirmOtp(email: emailController.text))) ;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
@override
  void dispose() {
emailController.dispose();
super.dispose();
  }

}
