import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:layout/notifications.dart';
import 'package:layout/second_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Allow Notifications'),
                  content: const Text(
                      'This app would like to send you notifications'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Don\'t Allow ',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then(
                                (value) => Navigator.pop(context),
                              );
                        },
                        child: const Text(
                          'Allow',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
        );
      }
    });

    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Notification Created on ${notification.channelKey}')));
    });

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'bike_channel' || notification.channelKey == 'delayed_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const SecondPage(),
        ),
            (route) => route.isFirst,
      );
    });


  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notif2'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
              icon: const Icon(Icons.star_border))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  createBikeNotification();
                },
                child: const Text('Send Immediate Notification'),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  createDelayedBikeNotification();
                },
                child: const Text('Send Notification in 10 Seconds'),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  cancelScheduledNotifications();
                },
                child: const Text('Cancel Notifications'),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
