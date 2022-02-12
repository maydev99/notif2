

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:layout/utilities.dart';

Future<void> createBikeNotification() async {
  await AwesomeNotifications().createNotification(content: NotificationContent(
    id: createUniqueId(),
    channelKey: 'bike_channel',
    title: '${Emojis.animals_frog} Time to go biking!',
    body: 'Get on the bike and ride!',
      bigPicture: 'asset://assets/twobikes.jpg',
    notificationLayout: NotificationLayout.BigPicture
  ));
}

