import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:layout/utilities.dart';

Future<void> createBikeNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'bike_channel',
          title: '${Emojis.animals_frog} Time to go biking!',
          body: 'Get on the bike and ride!',
          bigPicture: 'asset://assets/twobikes.jpg',
          notificationLayout: NotificationLayout.BigPicture));


  }

Future<void> createDelayedBikeNotification() async {
  DateTime now = DateTime.now();

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'delayed_channel',
        title: '${Emojis.time_alarm_clock} Sent from the future!',
        body: 'It was time to bike 10 seconds ago',
        notificationLayout: NotificationLayout.Default),

    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Done',

      ),

    ],

    schedule: NotificationCalendar(

      weekday: now.weekday,
      hour: now.hour,
      minute: now.minute,
      second: now.second + 10,
      millisecond: 0,
      repeats: false,
    ),

  );
}
