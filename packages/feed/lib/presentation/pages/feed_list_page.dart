import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/presentation/widgets/loading_indicator.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../provider/feed_list_notifier.dart';
import '../widgets/feed_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  static const routeName = '/feed-list';

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<FeedListNotifier>(context, listen: false).fetchFeed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const AppBarLeading(),
        title: const AppBarTitle(title: "Feed"),
        actions: appBarActions(context),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: defaultMargin,
          top: 13,
          right: defaultMargin,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 9,
                  right: 9,
                  bottom: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Period",
                      style: TextStyle(
                        color: indigo,
                        fontSize: kBodyLarge,
                        fontFamily: medium,
                      ),
                    ),
                    Container(
                      width: 113,
                      height: 34,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF3EA1F1),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/date.svg'),
                          const SizedBox(width: 6),
                          const Text(
                            "Today",
                            style: TextStyle(
                              color: Color(0xFF3EA1F1),
                              fontSize: kBodySmall,
                              fontFamily: regular,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Consumer<FeedListNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.loading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: const Loading(),
                    );
                  } else if (data.state == RequestState.loaded) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final feed = data.feed[index];
                        return FeedCard(feed);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: 6,
                    );
                  } else {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
