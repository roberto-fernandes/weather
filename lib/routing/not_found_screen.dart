import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/localization/string_hardcoded.dart';
import 'package:weather/routing/app_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( '404 - Page not found!'.hardcoded),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.home.name),
              child: Text('Go Home'.hardcoded),
            )
          ],
        ),
      ),
    );
  }
}
