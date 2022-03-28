import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/pages/header_page.dart';
import 'package:flutter_instagram/services/data_service.dart';
import 'package:flutter_instagram/services/file_service.dart';
import 'package:flutter_instagram/widget_catalogs/glassmorphism_widget.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  static const String id = 'upload_page';
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController captionController = TextEditingController();

  bool isLoading = false;
  bool isDeleteImage = false;
  bool isUpload = false;
  File? image;

  /////////// ------------ Image upload from Gallery ------------ ////////////////

  Future pickImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      isDeleteImage = true;
      setState(() {
        isUpload = true;
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick image $e");
      }
    }
  }

  /////////// --------- Image upload from Camera ---------- ////////////////

  Future takeImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        isUpload = true;
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick image $e");
      }
    }
  }

  /////////// --------- for post ------------ ////////////////

  void _uploadNewPost() {
    String caption = captionController.text.trim().toString();
    if(caption.isEmpty || image == null) return;

    //
    _firePostImage();
  }

  ////////// ---------- Fire post image ------ /////////////

  void _firePostImage() {
    setState(() {
      isLoading = true;
    });

    FileService.uploadImage(image!, FileService.folderPostImg).then((imageUrl) => {
      _resPostImage(imageUrl),
    });
  }

  /////////// --------- res post Image --------- ////////////////

  void _resPostImage(String imageUrl) {
    String caption = captionController.text.trim().toString();
    Post post = Post(postImage: imageUrl, caption: caption);
    _fireStorePost(post);
  }

  /////////// --------data service store post---------------- ////////////////

  void _fireStorePost(Post post) async {

    // Post to posts folder
    Post posted = await DataService.storePost(post);

    // post to feeds folder
    DataService.storeFeed(posted).then((value) => {
      _moveToFeed(),
    });
  }

  /////////// ----------from upload page to Header page--------- ////////////////

  void _moveToFeed() {
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, HeaderPage.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload", style: TextStyle(fontFamily: 'Billabong'),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_photo_alternate, color: Colors.red.shade400,),
            onPressed: (){
              _uploadNewPost();
            },
            splashRadius: 10,
            padding: const EdgeInsets.only(right: 8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [

                // #image upload
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        context: context,
                        builder: (BuildContext context){
                          return uploadBottomSheet(context);
                        });
                    },
                  child: Stack(
                    children: [

                      // #upload image
                      isUpload && image != null ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(image!, fit: BoxFit.cover,)
                      )
                      : Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade600,
                        child: const Icon(Icons.add_a_photo_rounded),
                      ),

                      // #iconButton close
                      isUpload ? Positioned(
                        top: 15,
                        right: 15,
                        child: GlassMorphism(
                          start: 0.3,
                          end: 0.3,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.black, size: 20,),
                            onPressed: (){
                              setState(() {
                                isUpload = false;
                              });
                            },
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                ),

                // #caption textFields
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: captionController,
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: null,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Caption',
                      hintStyle: TextStyle(fontSize: 17.0, color: Colors.black38)
                    ),
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
    );
  }

  Widget uploadBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.image),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Pick Photo", style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: takeImage,
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.camera_alt),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Take Photo", style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
