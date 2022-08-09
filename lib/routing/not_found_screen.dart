import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/routing/app_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('404 - Page not found!'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.home.name),
              child: const Text('Go Home'),
            )
          ],
        ),
      ),
    );
  }
}
