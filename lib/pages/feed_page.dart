import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  static const String id = 'feed_page';
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  bool isLike = false;
  final imageList = [
    "https://i.pinimg.com/originals/e3/0e/f7/e30ef76f381156b63bb4ff6474e177db.jpg",
    'https://wallpaperaccess.com/full/5707282.jpg',
    "https://www.teahub.io/photos/full/10-105274_tokyo-ghoul-wallpaper-3d.jpg",
    "https://wallpapershome.com/images/pages/pic_v/15972.jpg",
    "https://justanimehype.com/wp-content/uploads/2021/11/Gojo-Satoru-from-Jujutsu-Kaisen-1024x576.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpJAs_B5ADglytUXKarCh5AACVfF2QROpUGmfGT2P02yCf-5bse8QDuc7TXzgciMJj0fs&usqp=CAU",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram", style: TextStyle(fontFamily: 'Billabong', fontSize: 30,),),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black.withOpacity(0.9),),
            onPressed: (){},
            splashRadius: 10,
            padding: const EdgeInsets.only(right: 8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // #story
            Container(
              color: Colors.white,
              height: 126,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // #story my
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 7.5, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Stack(
                          children: const [
                             SizedBox(
                              child: CircleAvatar(
                                radius: 36,
                                foregroundImage: AssetImage("assets/images/img_1.png"),
                              ),
                              height: 72,
                              width: 72,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 3,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.add, color: Colors.white, size: 12,),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Your story", style: TextStyle(color: Colors.black),)
                      ],
                    ),
                  ),
                  // #story
                  SizedBox(
                    height: 126,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.red,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 38,
                                    child: CircleAvatar(
                                      radius: 36,
                                      foregroundImage: AssetImage("assets/images/img_1.png"),
                                    ),
                                  ),
                                ),
                                height: 80,
                                width: 80,
                              ),

                              SizedBox(
                                height: 3,
                              ),
                              Text("Yamamoto", style: TextStyle(color: Colors.black),)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            //
            Divider(
              height: 1.5,
              color: Colors.grey.shade500,
            ),
            // #content
            ListView.builder(
              itemCount: imageList.length,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index){
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            // #user info
                            Row(
                              children: const [

                                // #user image
                                SizedBox(
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.red,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 26,
                                      child: CircleAvatar(
                                        radius: 24,
                                        foregroundImage: AssetImage("assets/images/img_1.png"),
                                      ),
                                    ),
                                  ),
                                  height: 56,
                                  width: 56,
                                ),

                                //
                                SizedBox(
                                  width: 10,
                                ),

                                // #user name
                                Text("Yakasara Murito", style: TextStyle(color: Colors.black),),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.more_vert_outlined, color: Colors.black.withOpacity(0.9),),
                              onPressed: (){},
                              splashRadius: 10,
                              padding: const EdgeInsets.only(right: 5),
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),

                      // #content
                      GestureDetector(
                        child: Image(
                          image: NetworkImage(imageList[index]),
                          fit: BoxFit.cover,
                        ),
                        onDoubleTap: (){
                          setState(() {
                            isLike = true;
                          });
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            // #user info
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(isLike ? Icons.favorite : Icons.favorite_border, color: isLike ? Colors.red : Colors.black.withOpacity(0.9),),
                                  onPressed: (){},
                                  splashRadius: 10,
                                  padding: const EdgeInsets.only(left: 5, right: 10),
                                  constraints: const BoxConstraints(),
                                ),
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.comment, color: Colors.black.withOpacity(0.9),),
                                  onPressed: (){},
                                  splashRadius: 10,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  constraints: const BoxConstraints(),
                                ),
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.paperPlane, color: Colors.black.withOpacity(0.9), size: 26,),
                                  onPressed: (){},
                                  splashRadius: 10,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.bookmark_border_sharp, color: Colors.black.withOpacity(0.9),),
                              onPressed: (){},
                              splashRadius: 10,
                              padding: const EdgeInsets.only(right: 5),
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
