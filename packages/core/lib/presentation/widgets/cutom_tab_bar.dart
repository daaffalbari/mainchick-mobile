import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/text_styles.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
  }) : super(key: key);

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TabBar(
        labelStyle: const TextStyle(
          fontSize: kBodyMedium,
          fontFamily: medium,
        ),
        controller: controller,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kPrimaryColor,
        ),
        unselectedLabelColor: const Color(0xFF888888),
        labelColor: white,
        padding: const EdgeInsets.all(5),
        labelPadding: EdgeInsets.zero,
        tabs: tabs,
      ),
    );
  }
}
