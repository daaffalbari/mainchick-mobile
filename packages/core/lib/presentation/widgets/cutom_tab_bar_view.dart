import 'package:flutter/material.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({
    Key? key,
    required this.controller,
    required this.children,
  }) : super(key: key);

  final TabController controller;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: children,
      ),
    );
  }
}
