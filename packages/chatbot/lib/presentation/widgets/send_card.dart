import 'package:chatbot/domain/entities/chat.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendCard extends StatelessWidget {
  const SendCard(this.chat, {Key? key}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 11),
            padding:
                const EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 10),
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.00, -0.02),
                end: Alignment(1, 0.02),
                colors: [Color(0xFFF9B76A), Color(0xFFFF8900)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x72FFA53D),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Text(
              chat.text,
              style: TextStyle(color: white),
              textAlign: TextAlign.end,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset('assets/icons/clock.svg'),
              const SizedBox(width: 2),
              Text(chat.createdAt.timeAgo, style: TextStyle(color: grey))
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
