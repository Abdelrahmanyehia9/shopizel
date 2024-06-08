import 'package:flutter/material.dart';

import '../../../../core/screen_dimentions.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_container.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/auth_textfeild.dart';
import '../widgets/formfeild_label.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

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
            tittle: "Sign Up",
            subTittle: "Please sign up to get started",
          ),
          AuthFormContainer(
              form: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  signUp(),
                  const SizedBox(
                    height: 18,
                  ),
                  PrimaryButton(
                    label: "Sign up",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget signUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 14,
        ),
        const FormfeildLabel(
          label: "Name",
        ),
        AuthTextfeild(
          controller: nameController,
          initialValue: "John doe",
        ),
        const SizedBox(
          height: 5,
        ),
        const FormfeildLabel(
          label: "Email",
        ),
        AuthTextfeild(
          controller: nameController,
          initialValue: "example@gmail.com",
        ),
        const SizedBox(
          height: 5,
        ),
        const FormfeildLabel(
          label: "Psssword",
        ),
        AuthTextfeild(
          controller: passwordController,
          initialValue: "**********",
          isPassword: true,
        ),
        const SizedBox(
          height: 5,
        ),
        const FormfeildLabel(
          label: "Re-Type Password",
        ),
        AuthTextfeild(
          controller: passwordConfirmController,
          initialValue: "**********",
          isPassword: true,
        )
      ],
    );
  }
  @override
  void dispose() {
    nameController.dispose() ;
    emailController.dispose() ;
    passwordController.dispose() ;
    passwordConfirmController.dispose() ;
    super.dispose();
  }
}
