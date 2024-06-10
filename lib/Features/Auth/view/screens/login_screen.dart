import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppizel/Features/Auth/controller/authentication_cubit.dart';
import 'package:shoppizel/Features/Auth/controller/authentication_state.dart';
import 'package:shoppizel/Features/Auth/view/screens/forget_password_screen.dart';
import 'package:shoppizel/Features/Auth/view/screens/sigup_screen.dart';
import 'package:shoppizel/Features/Auth/view/widgets/auth_textfeild.dart';
import 'package:shoppizel/core/app_constants.dart';
import 'package:shoppizel/core/screen_dimentions.dart';
import 'package:shoppizel/core/utils/snackbars.dart';
import 'package:shoppizel/core/utils/validation.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_container.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/formfeild_label.dart';
import '../widgets/remember_me_checkBox.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  bool rememberMeIsChecked = false;
  final TextEditingController passwordController = TextEditingController();
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
            isHome: true,
            tittle: "Login",
            subTittle: "Please sign in to your existing account",
          ),
          AuthFormContainer(
              form: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  loginForm(key: _globalKey),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RemeberMe(
                        onChanged: (bool? value) {},
                        isChecked: rememberMeIsChecked,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const ForgetPasswordScreen()));
                        },
                        child: const Text(
                          "Forget Password",
                          style: TextStyle(
                              fontFamily: AppConstants.fontFamily,
                              fontSize: 14,
                              color: AppConstants.btnColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocConsumer<LoginCubit, SignUpState>(
                      builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }
                    return PrimaryButton(
                        label: "Log in",
                        onTap: () {
                          if (_globalKey.currentState!.validate()) {
                            context
                                .read<LoginCubit>()
                                .loginByEmailAndPassword(emailController.text,
                                    passwordController.text);
                          }
                        });
                  }, listener: (context, state) {
                    if (state is LoginSuccess) {
                     SnackBars.CustomSnackBar(context: context, desc: "good", tittle: "good", type: AnimatedSnackBarType.success) ;

                    }
                    else if (state is LoginFailure) {
                      SnackBars.CustomSnackBar(
                          context: context,
                          tittle: "Login error",
                          desc: state.errorCode,
                          type: AnimatedSnackBarType.error);
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account?",
                          style: GoogleFonts.sen(
                              color: const Color(0xff646982), fontSize: 16),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUpScreen()));
                          },
                          child: Text(
                            "Sign up".toUpperCase(),
                            style: GoogleFonts.sen(
                                color: AppConstants.btnColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Or",
                    style: GoogleFonts.sen(
                        fontSize: 16, color: const Color(0xff646982)),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                      width: screenWidth(context) * 0.7, child: socialIcons())
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget loginForm({required GlobalKey key}) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          const FormfeildLabel(
            label: "email",
          ),
          AuthTextfeild(
            validator: (String? value) {
              if (!Validation.emailValidation(value!)) {
                return "email bad Formatted";
              }
            },
            controller: emailController,
            initialValue: "example@gmail.com",
          ),
          const SizedBox(
            height: 5,
          ),
          const FormfeildLabel(
            label: "password",
          ),
          AuthTextfeild(
            controller: passwordController,
            initialValue: "**********",
            isPassword: true,
          )
        ],
      ),
    );
  }

  Widget socialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          "assets/images/Facebook.svg",
        ),
        SvgPicture.asset(
          "assets/images/Twitter.svg",
        ),
        SvgPicture.asset(
          "assets/images/Apple.svg",
        )
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
