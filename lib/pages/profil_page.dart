import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const String id = 'profile_page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TabController controller;
  int posts = 14;
  int followers = 140;
  int following = 120;
  String fullname = "Yamata Murito";
  String bio = "Japan International University of Information Technologies Japan International University of Information Technologies Japan International University of Information Technologies";
  String url = "t.me/yamata/";

  final imageGrid = [
    "https://i.pinimg.com/originals/e3/0e/f7/e30ef76f381156b63bb4ff6474e177db.jpg",
    'https://wallpaperaccess.com/full/5707282.jpg',
    "https://www.teahub.io/photos/full/10-105274_tokyo-ghoul-wallpaper-3d.jpg",
    "https://wallpapershome.com/images/pages/pic_v/15972.jpg",
    "https://justanimehype.com/wp-content/uploads/2021/11/Gojo-Satoru-from-Jujutsu-Kaisen-1024x576.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpJAs_B5ADglytUXKarCh5AACVfF2QROpUGmfGT2P02yCf-5bse8QDuc7TXzgciMJj0fs&usqp=CAU",
    "https://i.pinimg.com/originals/e3/0e/f7/e30ef76f381156b63bb4ff6474e177db.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("mr.yamata", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              IconButton(
                onPressed: (){
                },
                splashRadius: 10,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            ],
          ),
          actions: [

            // log out user
            IconButton(
              onPressed: (){
                AuthService.signOutUser(context);
              },
              icon: const Icon(Icons.add_box_outlined, color: Colors.black,),
              padding: EdgeInsets.zero,
            ),

            // delete account
            IconButton(
              onPressed: (){
                AuthService.deleteAccount(context);
              },
              icon: const Icon(Icons.dehaze, color: Colors.black,),
              padding: const EdgeInsets.only(right: 10),
            ),

          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              // user
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        foregroundImage: AssetImage("assets/images/img_1.png"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // posts
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(posts.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),),
                              Text("Posts", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black.withOpacity(0.9)),),
                            ],
                          ),

                          //
                          const SizedBox(
                            width: 15,
                          ),

                          // follower
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(followers.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),),
                              Text("Followers", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black.withOpacity(0.9)),),
                            ],
                          ),

                          //
                          const SizedBox(
                            width: 15,
                          ),
                          // following
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(following.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),),
                              Text("Following", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black.withOpacity(0.9)),),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              // user info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // fullname
                    Text(fullname, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                    const SizedBox(
                      height: 3,
                    ),

                    // bio
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(bio, style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black87),
                        overflow: TextOverflow.clip,
                        )),

                    // url
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.topCenter,
                        // onpress color
                        primary: Colors.white
                      ),
                        onPressed: (){},
                        child: Text(url, style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.blue),)),
                  ],
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // profile edit
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.9 - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          width: 1.2,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              // onpress color
                              primary: Colors.white
                          ),
                          onPressed: (){},
                          child: const Text("Edit profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)),
                    ),


                    // person add
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          width: 1.2,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.person_add, color: Colors.black,),
                          onPressed: (){},
                          splashRadius: 15,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    ),
                  ],
                ),
              ),

              const TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 1.3,
                unselectedLabelColor: Colors.black54,
                labelColor: Colors.black,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on_outlined)),
                  Tab(icon: Icon(Icons.account_box),)
                ],
              ),

              const Divider(
                height: 1.0,
                color: Colors.white,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.5,
                child: TabBarView(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: 3
                      ),
                      itemCount: imageGrid.length,
                      itemBuilder: (context, index){
                        return CachedNetworkImage(
                          imageUrl: imageGrid[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.blueGrey.shade600,
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          crossAxisCount: 3
                      ),
                      itemCount: 2,
                      itemBuilder: (context, index){
                        return CachedNetworkImage(
                          imageUrl: imageGrid[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.blueGrey.shade600,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
