// import 'dart:convert';
//
// class Users {
//   Users({
//     required this.uid,
//     required this.fullname,
//     required this.email,
//     required this.password,
//     required this.imageUrl,
//     required this.followed,
//     required this.followerCount,
//     required this.followingCount,
//   });
//
//   String uid;
//   String fullname;
//   String email;
//   String password;
//   String? imageUrl;
//   bool followed;
//   int followerCount;
//   int followingCount;
//
//   factory Users.fromJson(Map<String, dynamic> json) => Users(
//     uid: json["uid"],
//     fullname: json["fullname"],
//     email: json["email"],
//     password: json["password"],
//     imageUrl: json["imageUrl"],
//     followed: json["followed"],
//     followerCount: json["followerCount"],
//     followingCount: json["followingCount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "uid": uid,
//     "fullname": fullname,
//     "email": email,
//     "password": password,
//     "imageUrl": imageUrl,
//     "followed": followed,
//     "followerCount": followerCount,
//     "followingCount": followingCount,
//   };
//
//   @override
//   bool operator == (Object other) {
//     return (other is Users) && other.uid = uid;
//   }
//
//   @override
//   int get hashCode => uid.hashCode;
// }

class Users {
  String uid = "";
  late String fullName;
  late String email;
  late String password;
  String? imageUrl;
  bool followed = false;
  int followersCount = 0;
  int followingCount = 0;

  Users({required this.fullName, required this.email, required this.password});

  Users.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    fullName = json["fullName"];
    email = json["email"];
    password = json["password"];
    imageUrl = json["imageUrl"];
    followingCount = json["followingCount"];
    followersCount = json["followersCount"];
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "fullName": fullName,
    "email": email,
    "password": password,
    "imageUrl": imageUrl,
    "followersCount": followersCount,
    "followingCount": followingCount,
  };

  @override
  bool operator ==(Object other) {
    return other is Users && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}