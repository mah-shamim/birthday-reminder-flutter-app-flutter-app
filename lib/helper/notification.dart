import 'package:birthday_reminder/helper/common_import.dart';
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iOSSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iOSSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      debugPrint('Notification clicked with payload: ${response.payload}');
    },
  );

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // _showNotificationFromMessage(message);
    debugPrint('Message ----- $message');
    // await zonedScheduleNotification();
  });

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

// Show notification based on Firebase message
Future<void> showNotificationFromMessage() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.high,
    priority: Priority.high,
  );
  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Hello!',
    'This is a local notification.',
    platformDetails,
  );
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Background Notification $message');
}

Future<void> getToken() async {
  Settings.fcmToken = await messaging.getToken() ?? '';
}

Future<void> zonedScheduleNotification(tz.TZDateTime scheduledDate, String name, String title, int id, int notificationId) async {
  /* debugPrint('UTC --------- ${tz.TZDateTime.now(tz.UTC)}');
  debugPrint('local --------- ${tz.TZDateTime.now(tz.local)}');*/
  debugPrint('notificationId --------- $notificationId');
  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
  await flutterLocalNotificationsPlugin.zonedSchedule(
    notificationId,
    '$title Reminder!',
    name,
    scheduledDate,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        enableVibration: true,
      ),
      iOS: iosDetails,
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  );

  List<PreferencesModel> notificationIdList = [];
  notificationIdList = Settings.preferencesList;
  var data = PreferencesModel(id: id, notificationID: notificationId);
  notificationIdList.add(data);
  Settings.savePreferencesList(notificationIdList);
  debugPrint('NotificationId ~~~ ${Settings.preferencesList.length}');
}

Future<void> closeNotification(int id) async {
  debugPrint("cancel Notification --------> $id");
  flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
  debugPrint('Close all the pending notification');
}
