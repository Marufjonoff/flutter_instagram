import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/control_page.dart';
import 'package:flutter_instagram/pages/header_page.dart';
import 'package:flutter_instagram/pages/sign_in_page.dart';
import 'package:flutter_instagram/pages/views/validate_textField.dart';
import 'package:flutter_instagram/services/utils.dart';
import 'package:flutter_instagram/widget_catalogs/glassmorphism_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String id = "sign_up_page";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with InputValidation {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(88, 81, 216, 1.0),
                  Color.fromRGBO(131, 58, 180, 1.0),
                  Color.fromRGBO(193, 53, 132, 1.0),
                  Color.fromRGBO(225, 48, 108, 1.0),
                  Color.fromRGBO(245, 96, 64, 1.0),
                ]
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // #text
                  const Text(
                    'Instagram',
                    style: TextStyle(fontFamily: 'Billabong', fontSize: 25),),

                  const SizedBox(
                    height: 25,
                  ),

                  // #email field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GlassMorphism(
                      start: 0.4,
                      end: 0.4,
                      child: TextFormField(
                        controller: fullNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Fullname',
                            contentPadding: EdgeInsets.only(left: 15, right: 15)
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  // #password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GlassMorphism(
                      start: 0.4,
                      end: 0.4,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            contentPadding: EdgeInsets.only(left: 15, right: 15)
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  // #password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GlassMorphism(
                      start: 0.4,
                      end: 0.4,
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            contentPadding: EdgeInsets.only(left: 15, right: 15)
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  // #password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GlassMorphism(
                      start: 0.4,
                      end: 0.4,
                      child: TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            contentPadding: EdgeInsets.only(left: 15, right: 15)
                        ),
                      ),
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 12,
                  ),

                  // #button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GlassMorphism(
                      start: 0.0,
                      end: 0.0,
                      child: MaterialButton(
                        onPressed: (){
                          if(isEmailValid(emailController.text.trim())
                          && isPasswordValid(passwordController.text.trim())
                          && isConfirmPasswordValid(confirmPasswordController.text.trim())) {
                            Navigator.pushReplacementNamed(context, ControlPage.id);
                          } else {
                            Utils.showToast(context, "Email or password invalid");
                          }
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: const Text("Sign Up"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, SignInPage.id);
                        },
                        child: const Text("Sign In"),
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
