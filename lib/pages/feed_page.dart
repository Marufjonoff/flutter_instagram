import 'package:awesome_icons/awesome_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/pages/likes_page.dart';
import 'package:flutter_instagram/services/data_service.dart';
import 'package:flutter_instagram/services/utils.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  static const String id = 'feed_page';
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  bool isLoading = true;
  List<Post> items = [];
  Users? users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fireLoadFeeds();
    // _apiLoadUser();
  }

  //// ---- For user load ----- ////
  // void _apiLoadUser() async {
  //   if(mounted) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //   }
  //   DataService.loadUser().then((value) => _showUserInfo(value));
  // }
  //
  // //// ----- Show user info ----- ////
  // void _showUserInfo(Users user) {
  //   if(mounted) {
  //     setState(() {
  //       users = user;
  //       isLoading = false;
  //     });
  //   }
  // }

  //// ----- Fire load feeds ----- ////
  void _fireLoadFeeds() async {
    if(mounted) {
      setState(() {
        isLoading = true;
      });
    }

    DataService.loadFeeds().then((posts) => {
      _resLoadFeeds(posts),
    });
  }

  //// ----- Res load feeds ---- /////
  void _resLoadFeeds(List<Post> posts) {
    if(mounted) {
      setState(() {
        isLoading = false;
        items = posts;
      });
    }
  }

  //// ----- Fire post like ----- /////
  void _firePostLike(Post post) async {
    if(mounted) {
      setState(() {
        isLoading  = true;
      });
    }

    await DataService.likePost(post, true);

    setState(() {
      isLoading = false;
      post.isLiked = true;
    });
  }

  //// ----- Fire post unlike ----- ////
  void _firePostUnlike(Post post) async {
    if(mounted) {
      setState(() {
        isLoading  = true;
      });
    }

    await DataService.likePost(post, false);

    if(mounted) {
      setState(() {
        isLoading = false;
        post.isLiked = false;
      });
    }
  }

  //// ----- update like ----- ////
  void updateLike(Post post) {
    if(!post.isLiked) {
      _firePostLike(post);
    }

    else {
      _firePostUnlike(post);
    }
  }

  //// ----- Remove post ----- ////
  void deletePost(Post post) async {
    bool result = await Utils.dialogCommon(context, "Instagram Clone", "Do yu want to remove this post?", false);

    if(result) {
      setState(() {
        isLoading = true;
      });

      await DataService.removePost(post);

      setState(() {
        isLoading = false;
      });

      _fireLoadFeeds();
    }
  }

  //// ----- Page to page animation ----- /////
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LikesPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram", style: TextStyle(fontFamily: 'Billabong', fontSize: 30,),),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black.withOpacity(0.9),),
            onPressed: (){
              Navigator.of(context).push(_createRoute());

            },
            splashRadius: 10,
            padding: const EdgeInsets.only(right: 8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                              children: [

                                 SizedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(32.0),
                                    child: users?.imageUrl == null || users!.imageUrl!.isEmpty ? const Image(
                                      image: AssetImage("assets/images/img.jpg"),
                                      fit: BoxFit.cover,
                                      height: 32,
                                      width: 32,
                                    ) : Image(
                                      image: NetworkImage(users!.imageUrl!),
                                      fit: BoxFit.cover,
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                  height: 64,
                                  width: 64,
                                ),

                                const Positioned(
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
                          itemCount: items.length,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: CircleAvatar(
                                      radius: 36,
                                      backgroundColor: Colors.red,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(34),
                                        child: users?.imageUrl != null ? CachedNetworkImage(
                                          height: 68,
                                          width: 68,
                                          imageUrl: users!.imageUrl!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Image(image: AssetImage("assets/images/img.jpg")),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ) : const Image(image: AssetImage("assets/images/img.jpg"), fit: BoxFit.cover,

                                        height: 68,
                                        width: 68,),
                                      ),
                                    ),
                                    height: 72,
                                    width: 72,
                                  ),

                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(users?.fullName == null ? "Hello " : users!.fullName , style: const TextStyle(color: Colors.black, fontSize: 14),)
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
                  itemCount: items.length,
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
                                  children:  [

                                    // #user image
                                    SizedBox(
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.red,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(16.0),
                                          child: items[index].imageUser != null ? CachedNetworkImage(
                                            height: 32,
                                            width: 32,
                                            fit: BoxFit.cover,
                                            imageUrl: items[index].imageUser!,
                                            placeholder: (context, url) => const Image(image: AssetImage("assets/images/img.jpg")),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ) : const Image(image: AssetImage("assets/images/img.jpg"), height: 32,
                                            width: 32,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      height: 36,
                                      width: 36,
                                    ),

                                    //
                                    const SizedBox(
                                      width: 10,
                                    ),

                                    // #user name
                                    Text(items[index].fullName, style: const TextStyle(color: Colors.black, fontSize: 14),),
                                  ],
                                ),

                                IconButton(
                                  icon: Icon(Icons.more_vert_outlined, color: Colors.black.withOpacity(0.9),),
                                  onPressed: (){
                                    deletePost(items[index]);
                                  },
                                  splashRadius: 10,
                                  padding: const EdgeInsets.only(right: 5),
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ),

                          // #content
                          GestureDetector(
                            child: CachedNetworkImage(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    imageUrl: items[index].postImage,
                                    placeholder: (context, url) => Container(
                                       width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width,
                                      color: Colors.blueGrey.shade700,),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                            onDoubleTap: (){
                              _firePostLike(items[index]);
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
                                      icon: Icon(items[index].isLiked ? Icons.favorite : Icons.favorite_border, color: items[index].isLiked ? Colors.red : Colors.black.withOpacity(0.9),),
                                      onPressed: (){
                                        updateLike(items[index]);
                                      },
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
                          // button


                          // likes
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Text("${items[index].isLiked} likes", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
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
                                      text: "${items[index].fullName} ",
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black,)
                                    ),
                                    TextSpan(
                                        text: items[index].caption,
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

            if(isLoading) Positioned(
              top: MediaQuery.of(context).size.height / 2 - 15,
              left: MediaQuery.of(context).size.width / 2 - 15,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
