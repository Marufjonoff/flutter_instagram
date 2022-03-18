import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/control_page.dart';
import 'package:flutter_instagram/pages/feed_page.dart';
import 'package:flutter_instagram/pages/header_page.dart';
import 'package:flutter_instagram/pages/likes_page.dart';
import 'package:flutter_instagram/pages/profil_page.dart';
import 'package:flutter_instagram/pages/search_page.dart';
import 'package:flutter_instagram/pages/sign_in_page.dart';
import 'package:flutter_instagram/pages/sign_up_page.dart';
import 'package:flutter_instagram/pages/splash_page.dart';
import 'package:flutter_instagram/pages/upload_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white,)
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        )
      ),
      home: const SplashPage(),
      routes: {
        ControlPage.id: (context) => ControlPage(),
        SplashPage.id: (context) => SplashPage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        HeaderPage.id: (context) => HeaderPage(),
        FeedPage.id: (context) => FeedPage(),
        SearchPage.id: (context) => SearchPage(),
        UploadPage.id: (context) => UploadPage(),
        LikesPage.id: (context) => LikesPage(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}

