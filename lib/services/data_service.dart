import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/services/pref_service.dart';
import 'package:flutter_instagram/services/utils.dart';

import 'http_service.dart';

class DataService {

  //// ----- FireBase instance ----- ////

  static final instance = FirebaseFirestore.instance;

  //// ----- Folder ----- ////

  static const String userFolder = "users";
  static const String postsFolder = "posts";
  static const String feedsFolder = "feeds";
  static const String followingsFolder = "followings";
  static const String followersFolder = "followers";

  //// ----- User store ----- ////

  static Future storeUser(Users user) async {
    user.uid = (await Prefs.load(StorageKeys.UID))!;

    Map<String, String> params = await Utils.deviceParams();

    user.device_id = params["device_id"]!;
    user.device_type = params["device_type"]!;
    user.device_token = params["device_token"]!;

    return instance.collection(userFolder).doc(user.uid).set(user.toJson());
  }

  //// ----- User load ----- ////

  static Future<Users> loadUser() async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var value = await instance.collection(userFolder).doc(uid).get();

    Users user = Users.fromJson(value.data()!);


    var querySnapshot1 = await instance.collection(userFolder).doc(uid).collection(followersFolder).get();
    user.followersCount = querySnapshot1.docs.length;

    var querySnapshot2 = await instance.collection(userFolder).doc(uid).collection(followingsFolder).get();
    user.followingCount = querySnapshot2.docs.length;

    return user;
  }

  //// ----- Update User ----- ////

  static Future updateUser(Users user) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    return instance.collection(userFolder).doc(uid).update(user.toJson());
  }

  //// ----- User search ----- ////

  static Future<List<Users>> searchUsers(String keyword) async {
    Users user = await loadUser();
    List<Users> users = [];
    var querySnapshot = await instance.collection(userFolder).orderBy("fullName").startAt([keyword]).endAt([keyword + '\uf8ff']).get();

    if (kDebugMode) {
      print("\nQuery Snapshots => ${querySnapshot.docs.toString()}\n");
    }

    for (var element in querySnapshot.docs) {
      users.add(Users.fromJson(element.data()));
    }

    users.remove(user);

    List<Users> following = [];
    var querySnapshot2 = await instance.collection(userFolder).doc(user.uid).collection(followingsFolder).get();

    for (var result in querySnapshot2.docs) {
      following.add(Users.fromJson(result.data()));
    }

    for(Users user in users){
      if(following.contains(user)){
        user.followed = true;
      }else{
        user.followed = false;
      }
    }
    return users;
  }

  // Post //

  ////----- Store Post ----- ///

  static Future<Post> storePost(Post post) async {

    // filled post
    Users me = await loadUser();
    post.uid = me.uid;
    post.fullName = me.fullName;
    post.imageUser = me.imageUrl;
    post.createdDate = DateTime.now().toString();

    String postId = instance.collection(userFolder).doc(me.uid).collection(postsFolder).doc().id;
    post.id = postId;

    await instance.collection(userFolder).doc(me.uid).collection(postsFolder).doc(postId).set(post.toJson());
    return post;
  }

  //// ----- Store feed ----- ////

  static Future<Post> storeFeed(Post post) async {
    await instance.collection(userFolder).doc(post.uid).collection(feedsFolder).doc(post.id).set(post.toJson());
    return post;
  }

  //// ----- Load feed ----- ////

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var querySnapshot = await instance.collection(userFolder).doc(uid).collection(feedsFolder).get();

    for (var element in querySnapshot.docs) {
      Post post = Post.fromJson(element.data());
      if(post.uid == uid) post.isMine = true;
      posts.add(post);
    }

    return posts;
  }

  //// ----- Load posts ----- ////

  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var querySnapshot = await instance.collection(userFolder).doc(uid).collection(postsFolder).get();

    for (var element in querySnapshot.docs) {
      Post post = Post.fromJson(element.data());
      posts.add(post);
    }

    return posts;
  }

  //// ----- Like post for feed Page ----- ////

  static Future<Post> likePost(Post post, bool like) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    post.isLiked = like;
    
    await instance.collection(userFolder).doc(uid).collection(feedsFolder).doc(post.id).update(post.toJson());
    
    if(uid == post.uid) {
      await instance.collection(userFolder).doc(uid).collection(postsFolder).doc(post.id).set(post.toJson());
    }
    return post;
  }

  //// ----- Like load ----- ////

  static Future<List<Post>> loadLike() async {
    String uid = (await Prefs.load(StorageKeys.UID))!;

    List<Post> posts = [];
    var querySnapshot = await instance.collection(userFolder).doc(uid).collection(feedsFolder).where("isLiked", isEqualTo: true).get();

    for(var element in querySnapshot.docs) {
      Post post = Post.fromJson(element.data());
      if(post.uid == uid) post.isMine = true;
      posts.add(post);
    }
    return posts;
  }

  //// ----- follower and following ----- ////

  static Future<Users> followUser(Users someone) async {
    Users me = await loadUser();

    await instance.collection(userFolder).doc(me.uid).collection(followingsFolder).doc(someone.uid).set(someone.toJson());

    await instance.collection(userFolder).doc(someone.uid).collection(followersFolder).doc(me.uid).set(me.toJson());

    // for notification

    await HttpService.POST(HttpService.paramCreate(someone.device_token, me.fullName, someone.fullName)).then((value) => {
      print("\n\nresponse notification: ${value.toString()}\n\n")
    });

    return someone;
  }

  //// ----- unfollow ----- ////

  static Future<Users> unfollow(Users someone) async {
    Users me = await loadUser();

    await instance.collection(userFolder).doc(me.uid).collection(followingsFolder).doc(someone.uid).delete();

    await instance.collection(userFolder).doc(someone.uid).collection(followersFolder).doc(me.uid).delete();

    return someone;
  }

  //// ----- Store Posts to my feed ----- ////

  static Future storePostsToMyFeed(Users someone) async {
    List<Post> posts = [];

    var querySnapshot = await instance.collection(userFolder).doc(someone.uid).collection(postsFolder).get();

    for(var item in querySnapshot.docs) {
      Post post = Post.fromJson(item.data());
      post.isLiked = false;
      posts.add(post);
    }

    for(Post post in posts) {
      storeFeed(post);
    }
  }

  //// ----- Remove posts from feed ----- ////

  static Future removePostsFromMyFeed(Users someone) async {

    // Remove someone`s posts from my feed
    List<Post> posts = [];

    var querySnapshot = await instance.collection(userFolder).doc(someone.uid).collection(postsFolder).get();
    for (var element in querySnapshot.docs) {
      posts.add(Post.fromJson(element.data()));
    }

    for(Post post in posts){
      removeFeed(post);
    }
  }

  //// ----- Remove feed ----- ////

  static Future removeFeed(Post post) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;

    return await instance.collection(userFolder).doc(uid).collection(feedsFolder).doc(post.id).delete();
  }

  //// ----- Remove post ----- ////

  static Future removePost(Post post) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    await removeFeed(post);

    return await instance.collection(userFolder).doc(uid).collection(postsFolder).doc(post.id).delete();
  }
}