import 'package:flutter/material.dart';

import 'package:userleap_flutter/userleap_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserleapFlutter.configure('ENVIRONMENT_ID');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        UserleapFlutter.presentDebugSurvey().then((value) =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('presentDebugSurvey')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        UserleapFlutter.setUserIdentifier('ekeh.wisdom@gmail.com')
                            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('setUserIdentifier')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        UserleapFlutter.setEmailAddress('ekeh.wisdom@gmail.com')
                            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('setEmailAddress')),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        UserleapFlutter.displaySurveyWithId(3200)
                            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('display survey with id')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        UserleapFlutter.setVisitorAttribute('gender', 'male')
                            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('setVisitorAttribute')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        UserleapFlutter.track('login')
                            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value.toString()))));
                      },
                      child: Text('track event')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        UserleapFlutter.logout().then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('logout')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
