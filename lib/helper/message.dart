import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

class Messaging {
  static final Client client = Client();

  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> "Server key"
  static const String serverKey =
      'AAAAxOYctBA:APA91bGXyZUS3uMzP-6na4nitVnT4FjIPa3HN3JCn1eWfzEWmApQgxCOYGWhMbxyPIeDzRSq42beMLLGVApT6tpzNQGV9CjAYypoL3vIJPJG2J0e8Tffh5exrErYC2OgeoiIBRbwCWgn';

  static Future<Response> sendToAll({
    @required String title,
    @required String body,
  }) =>
      sendToTopic(title: title, body: body, topic: 'all');

  static Future<Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String topic}) =>
      sendTo(title: title, body: body, fcmToken: '/topics/$topic');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String id,
    @required String fcmToken,
    String click_action,
    String userid,
    String userpic,
    String lan,
    String lat,
  }) =>
      client.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': click_action,
            'userid': userid,
            'userpic': userpic,
            'id': id,
            'lat': lat,
            'lan': lan,
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
