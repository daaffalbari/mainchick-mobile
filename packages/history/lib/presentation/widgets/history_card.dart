import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/string_extension.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/history.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard(this.history, {Key? key}) : super(key: key);

  final History history;

  @override
  Widget build(BuildContext context) {
    String month;

    if (history.date.month == 1) {
      month = 'January';
    } else if (history.date.month == 2) {
      month = 'February';
    } else if (history.date.month == 3) {
      month = 'March';
    } else if (history.date.month == 4) {
      month = 'April';
    } else if (history.date.month == 5) {
      month = 'May';
    } else if (history.date.month == 6) {
      month = 'June';
    } else if (history.date.month == 7) {
      month = 'July';
    } else if (history.date.month == 8) {
      month = 'August';
    } else if (history.date.month == 9) {
      month = 'September';
    } else if (history.date.month == 10) {
      month = 'October';
    } else if (history.date.month == 11) {
      month = 'November';
    } else {
      month = 'December';
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 27,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cage ${history.kandangName.getLastChar(1)}',
                  style: TextStyle(
                    color: indigo,
                    fontFamily: semiBold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${history.date.day} $month ${history.date.year}',
                  style: const TextStyle(
                    color: Color(0xFF3F5C92),
                    fontFamily: regular,
                    fontSize: kBodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Harvest amount : ${history.totalPanen}',
                  style: TextStyle(
                    color: kGreyScaleColor[500],
                    fontFamily: regular,
                    fontSize: kBodyMedium,
                  ),
                ),
                Text(
                  'Amount of feed : ${history.totalPakan}',
                  style: TextStyle(
                    color: kGreyScaleColor[500],
                    fontFamily: regular,
                    fontSize: kBodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
