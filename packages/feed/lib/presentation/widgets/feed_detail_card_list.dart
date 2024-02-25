import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/feed_detail.dart';

class FeedDetailCard extends StatelessWidget {
  const FeedDetailCard(this.feedDetail, {Key? key}) : super(key: key);

  final FeedDetail feedDetail;

  @override
  Widget build(BuildContext context) {
    String month;

    if (feedDetail.date.month == 1) {
      month = 'January';
    } else if (feedDetail.date.month == 2) {
      month = 'February';
    } else if (feedDetail.date.month == 3) {
      month = 'March';
    } else if (feedDetail.date.month == 4) {
      month = 'April';
    } else if (feedDetail.date.month == 5) {
      month = 'May';
    } else if (feedDetail.date.month == 6) {
      month = 'June';
    } else if (feedDetail.date.month == 7) {
      month = 'July';
    } else if (feedDetail.date.month == 8) {
      month = 'August';
    } else if (feedDetail.date.month == 9) {
      month = 'September';
    } else if (feedDetail.date.month == 10) {
      month = 'October';
    } else if (feedDetail.date.month == 11) {
      month = 'November';
    } else {
      month = 'December';
    }

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${feedDetail.date.day} $month ${feedDetail.date.year}',
                  style: TextStyle(
                    color: indigo,
                    fontSize: 16,
                    fontFamily: medium,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Chicken Death : ${feedDetail.ayamMati}',
                  style: TextStyle(
                    color: kGreyScaleColor[500],
                    fontSize: kBodyMedium,
                    fontFamily: regular,
                  ),
                ),
              ],
            ),
            Text(
              'Daily feed: ${feedDetail.pakan} kg',
              style: TextStyle(
                color: kGreyScaleColor[500],
                fontSize: kBodyMedium,
                fontFamily: regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
