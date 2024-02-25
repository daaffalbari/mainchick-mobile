import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarLeading extends StatelessWidget {
  const AppBarLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
