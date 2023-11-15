import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../presentation/assets/utils.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> handleBackground(RemoteMessage message) async {
    final bigPicturePath = await Utils.downloadFile(
        "https://pbs.twimg.com/profile_images/1624990846612549632/Hc0RW6F1_400x400.jpg",
        "largeImage");

    var androidPlatformChannel = AndroidNotificationDetails(
        'channel_id_course_5', 'channel_name',
        channelDescription: 'channel_desc',
        importance: Importance.max,
        styleInformation: BigPictureStyleInformation(
            FilePathAndroidBitmap(bigPicturePath),
            contentTitle: message.notification!.title,
            summaryText: message.notification!.body));
    var iOSPlatformChannel = DarwinNotificationDetails();
    var platformChannel = NotificationDetails(
        android: androidPlatformChannel, iOS: iOSPlatformChannel);

    await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, platformChannel);
  }

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    var fcmToken = await firebaseMessaging.getToken();
    print("FCM TOKEN :: $fcmToken");
    FirebaseMessaging.onBackgroundMessage(handleBackground);
  }
}
