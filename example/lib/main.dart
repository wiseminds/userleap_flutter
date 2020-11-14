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
                  child: FlatButton(
                      onPressed: () {
                        UserleapFlutter.presentDebugSurvey().then((value) =>
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('presentDebugSurvey')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        UserleapFlutter.setUserIdentifier('ekeh.wisdom@gmail.com')
                            .then((value) => Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('setUserIdentifier')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        UserleapFlutter.setEmailAddress('ekeh.wisdom@gmail.com')
                            .then((value) => Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('setEmailAddress')),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        UserleapFlutter.displaySurveyWithId(3200)
                            .then((value) => Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('display survey with id')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        UserleapFlutter.setVisitorAttribute('gender', 'male')
                            .then((value) => Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('setVisitorAttribute')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        UserleapFlutter.track('login')
                            .then((value) => Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(value?.toString() ?? ''))));
                      },
                      child: Text('track event')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        UserleapFlutter.logout().then((value) =>
                            Scaffold.of(context).showSnackBar(SnackBar(
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
