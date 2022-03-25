import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/header_page.dart';
import 'package:flutter_instagram/pages/sign_up_page.dart';
import 'package:flutter_instagram/pages/views/validate_textField.dart';
import 'package:flutter_instagram/services/auth_service.dart';
import 'package:flutter_instagram/services/pref_service.dart';
import 'package:flutter_instagram/services/utils.dart';
import 'package:flutter_instagram/widget_catalogs/glassmorphism_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const String id = "sign_in_page";
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with InputValidation{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formGlobalKey = GlobalKey();

  void callDoSignUp() {
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }

  bool isLoading = false;

  void _openHomePage() async {
    String email = emailController.text.trim().toString();
    String password = passwordController.text.trim().toString();

    if(email.isEmpty || password.isEmpty) {
      Utils.showToast(context, "Please complete all the fields");
      return;
    }

    setState(() {
      isLoading = true;
    });

    await AuthService.signInUser(email, password).then((response) {
      _getFirebaseUser(response);
    });
  }

  void _getFirebaseUser(Map<String, User?> map) async {
    setState(() {
      isLoading = false;
    });

    if(!map.containsKey("SUCCESS")) {
      if(map.containsKey("user-not-found")) Utils.showToast(context, "No user found for that email.");
      if(map.containsKey("wrong-password")) Utils.showToast(context, "Wrong password provided for that user.");
      if(map.containsKey("ERROR")) Utils.showToast(context, "Check Your Information.");
      return;
    }

    User? user = map["SUCCESS"];
    if(user == null) return;

    await Prefs.store(StorageKeys.UID, user.uid);
    Navigator.pushReplacementNamed(context, HeaderPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(52, 42, 241, 1.0),
                  Color.fromRGBO(131, 58, 180, 1.0),
                  Color.fromRGBO(193, 53, 132, 1.0),
                  Color.fromRGBO(225, 48, 108, 1.0),
                  Color.fromRGBO(245, 96, 64, 1.0),
                ]
              )
            ),
            child: Form(
              key: formGlobalKey,
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
                        const Text('Instagram', style: TextStyle(fontFamily: 'Billabong', fontSize: 25),),

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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                contentPadding: EdgeInsets.only(left: 15, right: 15),
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
                              controller: passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
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
                                if(isEmailValid(emailController.text.trim()) && isPasswordValid(passwordController.text.trim())) {
                                  _openHomePage();
                                } else {
                                  Utils.showToast(context, "Email or password invalid");
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: const Text("Sign In"),
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
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: callDoSignUp,
                              child: const Text("Sign Up"),
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          ),

          isLoading ? const Center(
            child:  CircularProgressIndicator(),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
