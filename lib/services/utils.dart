import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/services/pref_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Utils {
  static void showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(label: 'Undo', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  //// ----- Alert dialog ------ ////

  static Future<bool> dialogCommon(
      BuildContext context, String title, String msg, bool isSingle) async {
    return await showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              if (!isSingle)
                CupertinoDialogAction(
                  child: const Text("Cancel"),
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  },
                ),
              CupertinoDialogAction(
                child: const Text("Confirm"),
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        } else {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: const Text("Confirm"),
              )
            ],
          );
        }
      }
    );
  }

  //// ------ Device params ----- ////

  static Future<Map<String, String>> deviceParams() async {
    Map<String, String> params = {};
    var deviceInfo = DeviceInfoPlugin();
    String fcmToken = (await Prefs.load(StorageKeys.TOKEN))!;

    if(Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      params.addAll({
        'device_id': iosDeviceInfo.identifierForVendor!,
        'device_type': "I",
        'device_token': fcmToken,
      });
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      params.addAll({
        'device_id': androidDeviceInfo.androidId!,
        'device_type': "A",
        'device_token': fcmToken,
      });
    }

    return params;
  }

  //// ----- show local notification ----- ////

  static Future<void> showLocalNotification(RemoteMessage message) async {
    String title = message.notification!.title!;
    String body = message.notification!.body!;

    // if(Platform.isAndroid){
    //   title = message['notification']['title'];
    //   body = message['notification']['body'];
    // }

    var android = const AndroidNotificationDetails('channelId', 'channelName', channelDescription: 'channelDescription');
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);

    int id = Random().nextInt((pow(2, 31) - 1).toInt());
    await FlutterLocalNotificationsPlugin().show(id, title, body, platform);
  }
}