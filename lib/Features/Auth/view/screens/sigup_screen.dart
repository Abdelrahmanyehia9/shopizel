import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/function/validation.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../../../core/function/snackbars.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../controller/sign_up_cubit.dart';
import '../../controller/sign_up_state.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

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
                  signUp(key: _globalKey),
                  const SizedBox(
                    height: 18,
                  ),
                  BlocConsumer<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                      if (state is SignUpLoading) {
                        return const CircularProgressIndicator(
                            color: AppConstants.btnColor);
                      }

                      return PrimaryButton(
                        label: "Sign up",
                        onTap: () {
                          if (_globalKey.currentState!.validate()) {
                            context
                                .read<SignUpCubit>()
                                .signUpByEmailAndPassword(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text);
                          }
                        },
                      );
                    },
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        SnackBars.CustomSnackBar(
                            context: context,
                            desc: "your account has been submitted",
                            tittle: "Sign Up successed",
                            type: AnimatedSnackBarType.success);
                      } else if (state is SignUpFailure) {
                        SnackBars.CustomSnackBar(
                            context: context,
                            desc: state.errorCode,
                            tittle: "Sign Up error",
                            type: AnimatedSnackBarType.error);
                      }
                    },
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget signUp({required GlobalKey key}) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          const FormfeildLabel(
            label: "Full Name",
          ),
          AuthTextField(
            controller: nameController,
            initialValue: "John doe",
          ),
          const SizedBox(
            height: 5,
          ),
          const FormfeildLabel(
            label: "Email",
          ),
          AuthTextField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'this field is required';
              }
              if (!Validation.emailValidation(emailController.text.trim()!)) {
                return "email badly formatted";
              }
            },
            controller: emailController,
            initialValue: "example@gmail.com",
          ),
          const SizedBox(
            height: 5,
          ),
          const FormfeildLabel(
            label: "Psssword",
          ),
          AuthTextField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'this field is required';
              } else if (!Validation.passwordValidation(value!)) {
                return "Password Easy to Guess , Use Stronger Password";
              }
            },
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
          AuthTextField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'this field is required';
              } else if (value! != passwordController.text) {
                return "Password doesn't Match ";
              }
            },
            controller: passwordConfirmController,
            initialValue: "**********",
            isPassword: true,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }
}
