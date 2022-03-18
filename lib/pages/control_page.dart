import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/control_pages/camera_page.dart';
import 'package:flutter_instagram/pages/control_pages/chating_page.dart';
import 'package:flutter_instagram/pages/feed_page.dart';
import 'package:flutter_instagram/pages/header_page.dart';


class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  static const String id = "control_page";
  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentTap = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index){
          setState(() {
            _currentTap = index;
          });
        },
        children: const <Widget>[
          CameraPage(),
          HeaderPage(),
          ChatPage(),
        ],
      ),
    );
  }
}
