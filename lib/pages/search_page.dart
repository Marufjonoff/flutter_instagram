import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade200,
          ),
          child: TextField(
            controller: controller,
            onSubmitted: (text){
              // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              //   return SearchPage(sear: controller.text);
              // }));
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              prefixIcon: Icon(Icons.search, color: Colors.black,),
              isCollapsed: true,
            ),
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
            onTap: (){
              // print("Hello Field");
              // Navigator.push(
              //   context,
              //   PageRouteBuilder(
              //     transitionDuration: const Duration(seconds: 1),
              //     pageBuilder: (context, _, animation) => DetailPage(
              //       imageId: items[index].id,
              //       url: items[index].url,
              //     ),
              //   ),
              // );
            },
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
          color: Colors.grey,
        ),
      ),
    );
  }
}
