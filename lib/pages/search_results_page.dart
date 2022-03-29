import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/services/data_service.dart';

class ResultSearchPage extends StatefulWidget {
  const ResultSearchPage({Key? key}) : super(key: key);
  static const String id = "result_search_page";

  @override
  _ResultSearchPageState createState() => _ResultSearchPageState();
}

class _ResultSearchPageState extends State<ResultSearchPage> {
  TextEditingController controller = TextEditingController();
  List<Users> user = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _apiSearchUsers("");
  }

  void _apiSearchUsers(String keyword) {
    setState(() {
      isLoading = true;
    });
    DataService.searchUsers(keyword).then((users) => _resSearchUser(users));
  }

  void _resSearchUser(List<Users> users) {
    setState(() {
      isLoading = false;
      user = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.arrow_left, color: Colors.black,),
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
        ),
        title: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade200,
          ),
          child: TextField(
            cursorColor: Colors.grey.shade700,
            controller: controller,
            onChanged: (keyword) {
              _apiSearchUsers(keyword);
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              contentPadding: EdgeInsets.symmetric(vertical: 6),
              hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.black,),
            ),
          ),
        ),
      ),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: user.length,
        itemBuilder: (context, index) => itemOfUser(user[index]),
      ) ,
    );
  }

  Widget itemOfUser(Users user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.purpleAccent, width: 2)
          ),
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: user.imageUrl != null ? CachedNetworkImage(
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              imageUrl: user.imageUrl!,
              placeholder: (context, url) => const Image(image: AssetImage("assets/images/img.jpg")),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ) : const Image(image: AssetImage("assets/images/img.jpg"), height: 40, width: 40,),
          ),
        ),
        title: Text(user.fullName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        subtitle: Text(user.email, style: const TextStyle(color: Colors.black54,)),
        trailing: Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: MaterialButton(
            onPressed: () {},
            child: const Text("Follow", style: TextStyle(color: Colors.black87,), ),
          ),
        ),
      ),
    );
  }
}