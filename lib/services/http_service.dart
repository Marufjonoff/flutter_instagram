import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  static String BASE = 'fcm.googleapis.com';
  static String API_SEND = '/fcm/send';
  static Map<String, String> headers = {
    'Authorization': 'key= AAAAkbVPgGA:APA91bFrdKXSdg0f7EFCBq4kr8LN1yeMCzNWk9m1r7nI3BktGn23MZGRDxJbCNm7EUQtatH5xSK5d9ZsQGN5j5WqKzOrzAnLODsB6z9jL8zt5eKXvqQbWjElqkaMK7mKtixasg5pYRGP',
    'Content-Type': 'application/json'
  };

  static Future<String?> POST(Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, API_SEND);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Map<String, dynamic> paramCreate(String fcm_token, String username, String someoneName) {
    Map<String, dynamic> params = {};
    params.addAll({
      'notification': {
        'title': 'My Instagram: $someoneName',
        'body': '$username followed you!'
      },
      'registration_ids': [fcm_token],
      'click_action': 'FLUTTER_NOTIFICATION_CLICK'
    });
    return params;
  }
}