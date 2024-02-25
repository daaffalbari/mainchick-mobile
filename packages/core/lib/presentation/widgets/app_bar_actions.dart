import 'package:chatbot/presentation/pages/chatbot_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> appBarActions(BuildContext context) {
  return [
    IconButton(
      onPressed: () {
        Navigator.pushNamed(context, ChatBotPage.routeName);
      },
      icon: SvgPicture.asset('assets/icons/chat.svg'),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 21),
      child: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset('assets/icons/notification.svg'),
      ),
    ),
  ];
}
