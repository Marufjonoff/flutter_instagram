import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/feed_page.dart';
import 'package:flutter_instagram/pages/likes_page.dart';
import 'package:flutter_instagram/pages/profile_page.dart';
import 'package:flutter_instagram/pages/search_page.dart';
import 'package:flutter_instagram/pages/upload_page.dart';
import 'package:flutter_instagram/services/utils.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({Key? key}) : super(key: key);

  static const String id = 'header_page';
  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  final PageController _pageController = PageController();
  late int _currentTap = 0;

  _initNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message: ${message.notification.toString()}");
      Utils.showLocalNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Utils.showLocalNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int index){
          setState(() {
            _currentTap = index;
          });
        },
        children: const <Widget>[
          FeedPage(),
          SearchPage(),
          UploadPage(),
          LikesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1.0,
              color: Colors.grey.shade500
            )
          )
        ),
        child: CupertinoTabBar(
          iconSize: 24,
          inactiveColor: Colors.black,
          activeColor: Colors.purple,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, ), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search, ), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined,), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.favorite, ), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.perm_identity,), label: ''),
          ],
          currentIndex: _currentTap,
          onTap: (int index) {
            setState(() {
              _currentTap = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
