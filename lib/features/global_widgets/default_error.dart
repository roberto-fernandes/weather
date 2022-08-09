import 'package:flutter/material.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({
    this.title,
    this.tryAgainAction,
    Key? key,
  }): super(key: key);

  final String? title;
  final VoidCallback? tryAgainAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title ?? 'Error'),
          if (tryAgainAction != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: tryAgainAction,
                child: Text('Try Again'),
              ),
            )
        ],
      ),
    );
  }
}
