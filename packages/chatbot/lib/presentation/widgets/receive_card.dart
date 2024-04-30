import 'package:chatbot/domain/entities/chat.dart';
import 'package:chatbot/presentation/pages/prediction_detail_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceiveCard extends StatelessWidget {
  const ReceiveCard(this.chat, {Key? key}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 11),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFBDBDBD)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
            ),
            child: parseText(chat.text),
          ),
          Row(
            children: [
              SvgPicture.asset('assets/icons/clock.svg'),
              const SizedBox(width: 5),
              Text(chat.createdAt.timeAgo, style: TextStyle(color: grey))
            ],
          ),
          const SizedBox(height: 16),
          chat.prediction != null
              ? SizedBox(
                  width: 135,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: const BorderSide(
                        color: Color(0xFF3EA1F1),
                        width: 1,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PredictionDetailPage.routeName,
                        arguments: chat.prediction,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xFF3EA1F1),
                        ),
                        SizedBox(width: 3),
                        Text(
                          'See Detail',
                          style: TextStyle(
                            color: Color(0xFF3EA1F1),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget parseText(String text) {
    final RegExp boldRegex = RegExp(r'\*\*(.*?)\*\*');
    final List<TextSpan> textSpans = [];

    int start = 0;
    boldRegex.allMatches(text).forEach((match) {
      final String normalText = text.substring(start, match.start);
      if (normalText.isNotEmpty) {
        textSpans.add(TextSpan(text: normalText));
      }
      final String boldText = match.group(1)!;
      textSpans.add(TextSpan(
        text: boldText,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      start = match.end;
    });

    // Add remaining text after the last bold match
    final String remainingText = text.substring(start);
    if (remainingText.isNotEmpty) {
      textSpans.add(TextSpan(text: remainingText));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: textSpans,
      ),
    );
  }
}
