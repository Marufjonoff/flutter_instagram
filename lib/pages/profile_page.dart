import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/services/auth_service.dart';
import 'package:flutter_instagram/services/data_service.dart';
import 'package:flutter_instagram/services/file_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const String id = 'profile_page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TabController controller;
  int followers = 140;
  int following = 120;

  String bio = "Japan International University of Information Technologies Japan International University of Information Technologies Japan International University of Information Technologies";
  String url = "t.me/mrobidjon/";

  bool isLoading = false;
  List<Post> items = [];
  File? image;
  Users? users;
  int postCount = 0;

  @override
  void initState() {
    super.initState();
    _apiLoadUser();
    _apiLoadPost();
  }

  //// ----- Image upload from Gallery ----- ////

  Future pickImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      _apiChangePhoto();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick image $e");
      }
    }
  }

  //// ----- Image upload from Camera -----////

  Future takeImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      _apiChangePhoto();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick image $e");
      }
    }
  }

  //// ----- Bottom sheet ---- ////

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title:const Text('Photo Library'),
                    onTap: () {
                      pickImage();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    takeImage();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  //// ----- For user load ----- ////
  
  void _apiLoadUser() async {
    setState(() {
      isLoading = true;
    });
    DataService.loadUser().then((value) => _showUserInfo(value));
  }
  
  //// ----- Show user info ----- ////
  
  void _showUserInfo(Users user) {
    setState(() {
      users = user;
      isLoading = false;
    });
  } 
  
  //// ----- User profile Photo change -----////
  
  void _apiChangePhoto() {
    if(image == null) return;
    
    setState(() {
      isLoading = true;
    });
    FileService.uploadImage(image!, FileService.folderUserImg).then((value) => _apiUpdateUser(value));
  }
  
  //// ----- Update user imageUrl ----- ////
  
  void _apiUpdateUser(String imgUrl) async {
    setState(() {
      isLoading = false;
      users!.imageUrl = imgUrl;
    });
    await DataService.updateUser(users!);
  }
  
  //// ----- For load post ----- ////

  void _apiLoadPost() {
    DataService.loadPosts().then((posts) => {
      _resLoadPost(posts),
    });
  }

  //// ----- Result load post ----- ////

  void _resLoadPost(List<Post> posts) {
    setState(() {
      items = posts;
      postCount = posts.length;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(users == null ? "": users!.fullName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
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
                // AuthService.deleteAccount(context);
              },
              icon: const Icon(Icons.dehaze, color: Colors.black,),
              padding: const EdgeInsets.only(right: 10),
            ),

          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                          Stack(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.purpleAccent, width: 2)),
                                padding: const EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(75),
                                  child:  users?.imageUrl == null || users!.imageUrl!.isEmpty ? const Image(
                                    image: AssetImage("assets/images/img.jpg"),
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ) : Image(
                                    image: NetworkImage(users!.imageUrl!),
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height: 90,
                                width: 90,
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        _showPicker(context);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.purple,
                                      )),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // posts
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(postCount.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),),
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

                        // full name
                        Text(users == null ? "": users!.fullName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
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
                            // on press color
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
                                  // on press color
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
                          itemCount: items.length,
                          itemBuilder: (context, index){
                            return CachedNetworkImage(
                              imageUrl: items[index].postImage,
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
                          itemCount: items.length,
                          itemBuilder: (context, index){
                            return CachedNetworkImage(
                              imageUrl: items[index].postImage,
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

            if(isLoading) const Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
