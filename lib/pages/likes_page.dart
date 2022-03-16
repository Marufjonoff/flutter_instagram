import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);

  static const String id = 'likes_page';
  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  String username = "tillo_pharm098 and asadulloh";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity", style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // #user info
                Row(
                  children:  [
                    // #user image
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 18,
                        foregroundImage: AssetImage("assets/images/img_1.png"),
                      ),
                      height: 36,
                      width: 36,
                    ),
                    //
                    const  SizedBox(
                      width: 10,
                    ),
                    // #user name
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 106,
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(overflow: TextOverflow.ellipsis),
                            children: [
                              TextSpan(
                                  text: "$username ",
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black,)
                              ),
                              const TextSpan(
                                  text: "liked your video",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87,)
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),

                const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('assets/images/img_1.png'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
