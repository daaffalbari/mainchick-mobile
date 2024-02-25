import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/feed.dart';
import '../pages/feed_detail_page.dart';

class FeedCard extends StatelessWidget {
  const FeedCard(this.feed, {Key? key}) : super(key: key);

  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, FeedDetailPage.routeName,
              arguments: feed);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  feed.status
                      ? SvgPicture.asset('assets/icons/success.svg')
                      : SvgPicture.asset('assets/icons/alert.svg'),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cage ${feed.kandangName.getLastChar(1)}',
                        style: TextStyle(
                          color: indigo,
                          fontSize: 16,
                          fontFamily: semiBold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      status(),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset('assets/icons/arrow_right.svg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget status() {
    return feed.status == true
        // TODO fix time
        ? Text(
            'Today has been fed',
            style: TextStyle(
              color: kDisableButtonColor,
              fontSize: kBodyMedium,
              fontFamily: regular,
            ),
          )
        : Text(
            'Today has not been fed',
            style: TextStyle(
              color: kErrorColor,
              fontSize: kBodyMedium,
              fontFamily: regular,
            ),
          );
  }
}
