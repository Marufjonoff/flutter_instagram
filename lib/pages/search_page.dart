import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/pages/search_results_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const String id = 'search_page';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();
  List images = [];
  List<Users> user = [];

  bool isShimmer = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    images.addAll(image);
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        setState(() {
          for(int i = 0; i < 10; i++) {
            images.add(image[i]);
          }
        });
      }
    });
  }

  // //// ----- Search Users ----- ////
  //
  // void _fireSearchUsers(String keyword) {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   DataService.searchUsers(keyword).then((users) => _resSearchUsers(users));
  // }
  //
  // //// ----- Result searching user ----- /////
  //
  // void _resSearchUsers(List<Users> users) {
  //   setState(() {
  //     isLoading = false;
  //     user = users;
  //   });
  // }


  final image = [
    "https://i.pinimg.com/originals/e3/0e/f7/e30ef76f381156b63bb4ff6474e177db.jpg",
    'https://wallpaperaccess.com/full/5707282.jpg',
    "https://www.teahub.io/photos/full/10-105274_tokyo-ghoul-wallpaper-3d.jpg",
    "https://wallpapershome.com/images/pages/pic_v/15972.jpg",
    "https://justanimehype.com/wp-content/uploads/2021/11/Gojo-Satoru-from-Jujutsu-Kaisen-1024x576.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpJAs_B5ADglytUXKarCh5AACVfF2QROpUGmfGT2P02yCf-5bse8QDuc7TXzgciMJj0fs&usqp=CAU",
    "https://i.pinimg.com/originals/e3/0e/f7/e30ef76f381156b63bb4ff6474e177db.jpg",
    "https://i.pinimg.com/originals/e3/0e/f7/e30ef76f381156b63bb4ff6474e177db.jpg",
    'https://wallpaperaccess.com/full/5707282.jpg',
    "https://www.teahub.io/photos/full/10-105274_tokyo-ghoul-wallpaper-3d.jpg",
    "https://wallpapershome.com/images/pages/pic_v/15972.jpg",
    "https://justanimehype.com/wp-content/uploads/2021/11/Gojo-Satoru-from-Jujutsu-Kaisen-1024x576.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpJAs_B5ADglytUXKarCh5AACVfF2QROpUGmfGT2P02yCf-5bse8QDuc7TXzgciMJj0fs&usqp=CAU",
    "https://i.pinimg.com/originals/e3/0e/f7/e30ef76f381156b63bb4ff6474e177db.jpg",
  ];

  PageRouteBuilder _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const ResultSearchPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.0);
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
        elevation: 0.0,
        title: GestureDetector(
          onTap: (){
            Navigator.of(context).push(_createRoute());
            print("Search page");
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey.shade200,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(CupertinoIcons.search, color: Colors.black,),
                const SizedBox(
                  width: 15,
                ),
                Text("Search", style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w400),),
              ],
            )
          ),
        ),
      ),

      body: isShimmer ? Shimmer.fromColors(
        highlightColor: Colors.white54,
        baseColor: Colors.grey,
        enabled: isShimmer, child: Container(),
        )
        : GridView.custom(
        controller: scrollController,
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          repeatPattern: QuiltedGridRepeatPattern.same,
          pattern: [
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(2, 2),
            const QuiltedGridTile(1, 1),

            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),

            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),

            const QuiltedGridTile(2, 2),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),

            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),

            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
              (context, index) => GestureDetector(
                onTap: (){},
                child: itemOfCats(images[index]),
              ),
          childCount: images.length,
        ),
      ),
    );
  }

  Widget itemOfCats(String imageUrl) {
    return ClipRRect(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, text) => Container(
          color: Colors.blueGrey.shade700,
        ),
      ),
    );
  }
}
