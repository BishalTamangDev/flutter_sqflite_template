import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          spacing: 16.0,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
              size: 32.0,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.grey, fontSize: 16.0, height: 2.0),
            ),
          ],
        ),
      ),
    );
  }
}
