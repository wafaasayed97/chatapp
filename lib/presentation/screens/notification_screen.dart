import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance.collection('Notification').snapshots();
    notificationStream.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }
      showNotification(event.docs.first);
    });
    print(message);
    return Scaffold(
      appBar: AppBar(
        title: const Text(' push Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message.notification!.title.toString()),
            Text(message.notification!.body.toString()),
            Text(message.data.toString()),
          ],
        ),
      ),
    );
  }

  void showNotification(QueryDocumentSnapshot<Map<String, dynamic>> event) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('001', 'Local Notification',
            channelDescription: 'To send Local Notification');

    const NotificationDetails details = NotificationDetails(android: androidNotificationDetails, );
    flutterLocalNotificationsPlugin.show(01, event.get('title'), event.get('description'), details);
  }
}
