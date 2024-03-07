import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManger{
  // private constructor to avoid create object
  NotificationManger._();

  static FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// initialisation setting for all platform
  /// onNotificationPressed action when notification pressed to open tap
  /// onIOSNotificationPressed action when notification pressed
  /// to open tap in iOS versions older than 10
  static initialisation(
      Function(String) onNotificationPressed,
      DidReceiveLocalNotificationCallback onIOSNotificationPressed
    ) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon',);

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        onDidReceiveLocalNotification: onIOSNotificationPressed);

    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings();

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: onNotificationPressed);
  }

  // push new notification
  static Future showNotification(
      {
        @required String title,
        @required String subtext,
        @required int hashcode,
        String payload
      }) async {

    final AndroidNotificationDetails androidChannel = AndroidNotificationDetails(
      'com.technolca.wynch',
      'Wynch',
      'Push notification service for Wynch',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      channelShowBadge: true,
    );

    final IOSNotificationDetails iosChannel = IOSNotificationDetails(
        presentSound: true,
        presentBadge: true,
    );
    final MacOSNotificationDetails macOSChannel = MacOSNotificationDetails(
      presentSound: true,
      presentBadge: true,
    );

    final platformChannel = NotificationDetails(
      android: androidChannel,
      iOS: iosChannel,
      macOS: macOSChannel,
    );

    await localNotificationsPlugin.show(
      hashcode,
      title,
      subtext,
      platformChannel,
      payload: payload,
    );
  }

}