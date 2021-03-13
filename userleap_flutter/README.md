# userleap_flutter


[![pub package](https://img.shields.io/badge/Pub-0.0.1-green.svg)](https://pub.dartlang.org/packages/userleap_flutter)

A Flutter plugin integrating the official android and ios SDK for Userleap Survey Platform

<p align="center">
  <img src="https://github.com/wiseminds/userleap_flutter/raw/master/screenshot.png" alt="Screenshot" />
</p>


## Usage

Import `package:userleap_flutter/userleap_flutter.dart` and use the methods in `UserleapFlutter` class.



Example:
```dart
import 'package:userleap_flutter/userleap_flutter.dart';

void main() async {
    UserleapFlutter.configure('ENVIRONMENT_ID');
    runApp(App());
}

class App extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Center(
            child: FlatButton(
                onPressed: () {
                UserleapFlutter.presentDebugSurvey()
                .then((value) => print(value));
            },
            child: Text('Present Debug Survey'),
        ));
    }
}

```


See Userleap Android and iOS package documentation for more information.
[`USerleap docs`](https://docs.userleap.com/installation/)


Userleap requires a Fragment Activity for the android implementation to work, im your MainActivity.kt, you can change FlutterActivity to FlutterFragmentActivity.

```
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

}

```

Add Java 8 support to your project (if not added already)
``` 
android {
    ...
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    // For Kotlin projects
    kotlinOptions {
        jvmTarget = "1.8"
    }
}
```

Web support is currently in progress

checkout the example project for full implementation