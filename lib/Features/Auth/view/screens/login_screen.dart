import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppizel/Features/Auth/view/screens/forget_password_screen.dart';
import 'package:shoppizel/Features/Auth/view/screens/sigup_screen.dart';
import 'package:shoppizel/Features/Auth/view/widgets/auth_textfeild.dart';
import 'package:shoppizel/core/app_constants.dart';
import 'package:shoppizel/core/screen_dimentions.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_container.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/formfeild_label.dart';
import '../widgets/remember_me_checkBox.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  bool rememberMeIsChecked = false;
  final TextEditingController passwordController = TextEditingController();

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
                  loginForm(),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RemeberMe(
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMeIsChecked = value ?? false;
                          });
                        },
                        isChecked: rememberMeIsChecked,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const ForgetPasswordScreen()) );
                        },
                        child: Text(
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
                  PrimaryButton(
                    label: "Log in",
                    onTap: () {},
                  ),
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
                        InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpScreen())) ;
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

  Widget loginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 14,
        ),
        const FormfeildLabel(
          label: "email",
        ),
        AuthTextfeild(
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
