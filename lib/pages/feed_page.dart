import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  int likes = 12;
  String content = "Hello I'm Flutter developer. How old are you?. I'm from Uzbekistan. My name is Obidjon";
  String username = "yakasara_murito";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DateTime.now().toString());
    print(DateTime.now().toString().substring(13, 16));
  }
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
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // #story my
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 7, top: 6, bottom: 6),
                    child: Column(
                      children: [

                        Stack(
                          children: const [
                             SizedBox(
                              child: CircleAvatar(
                                radius: 32,
                                foregroundImage: AssetImage("assets/images/img_1.png"),
                              ),
                              height: 64,
                              width: 64,
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
                          height: 11,
                        ),
                        const Text("Your story", style: TextStyle(color: Colors.black, fontSize: 14),)
                      ],
                    ),
                  ),
                  // #story
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                child: CircleAvatar(
                                  radius: 36,
                                  backgroundColor: Colors.red,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 34,
                                    child: CircleAvatar(
                                      radius: 32,
                                      foregroundImage: AssetImage("assets/images/img_1.png"),
                                    ),
                                  ),
                                ),
                                height: 72,
                                width: 72,
                              ),

                              SizedBox(
                                height: 3,
                              ),
                              Text("Yamamoto", style: TextStyle(color: Colors.black, fontSize: 14),)
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            // #user info
                            Row(
                              children:  const [

                                // #user image
                                SizedBox(
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.red,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 16,
                                      child: CircleAvatar(
                                        radius: 14,
                                        foregroundImage: AssetImage("assets/images/img_1.png"),
                                      ),
                                    ),
                                  ),
                                  height: 36,
                                  width: 36,
                                ),

                                //
                                SizedBox(
                                  width: 10,
                                ),

                                // #user name
                                Text("Yakasara Murito", style: TextStyle(color: Colors.black, fontSize: 14),),
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
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageList[index]),
                              fit: BoxFit.cover,
                            )
                          ),
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: isLike ? Lottie.asset("assets/anime/favorite.json", repeat: false, width: 100, height: 100) : const SizedBox.shrink(),
                          ),
                        ),
                        onDoubleTap: (){
                          setState(() {
                            isLike = true;
                          });
                        },
                      ),

                      // button
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
                                  splashRadius: 15,
                                  padding: const EdgeInsets.only(left: 5, right: 10),
                                  constraints: const BoxConstraints(),
                                ),
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.comment, color: Colors.black.withOpacity(0.9),),
                                  onPressed: (){},
                                  splashRadius: 15,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  constraints: const BoxConstraints(),
                                ),
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.paperPlane, color: Colors.black.withOpacity(0.9), size: 26,),
                                  onPressed: (){},
                                  splashRadius: 15,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.bookmark_border_sharp, color: Colors.black.withOpacity(0.9),),
                              onPressed: (){},
                              splashRadius: 15,
                              padding: const EdgeInsets.only(right: 5),
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),

                      // likes
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text("${likes.toString()} likes", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                      ),

                      //content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(overflow: TextOverflow.ellipsis),
                              children: [
                                TextSpan(
                                  text: "$username ",
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black,)
                                ),
                                TextSpan(
                                    text: content,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87,)
                                ),
                              ]
                            ),
                          ),
                          height: 35,
                        ),
                      )

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
