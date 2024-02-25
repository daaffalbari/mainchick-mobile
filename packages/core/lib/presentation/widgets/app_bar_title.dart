import 'package:flutter/widgets.dart';

import '../../styles/text_styles.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: titleAppBarStyle,
    );
  }
}
