import 'package:flutter/material.dart';
import 'package:weather/localization/string_hardcoded.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('SettingsScreen onWillPop');
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'.hardcoded),
        ),
        body: SafeArea(
            child: Container(
              color: Colors.grey,
            )),
      ),
    );
  }
}
