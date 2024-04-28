import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/constants.dart';
import 'package:feed/presentation/provider/feed_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:notification/domain/entities/notification.dart'
    as notification_entity;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/date_extension.dart';
import 'package:provider/provider.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/presentation/widgets/loading_indicator.dart';
import 'package:feed/presentation/widgets/feed_card.dart';

class NotificationDetailPage extends StatefulWidget {
  const NotificationDetailPage({
    Key? key,
    required this.notification,
  }) : super(key: key);

  static const routeName = '/notification-detail';

  final notification_entity.Notification notification;

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
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
          leading: const AppBarLeading(),
          title: const AppBarTitle(title: 'Notification Detail'),
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: defaultMargin,
            top: 24,
            right: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    widget.notification.type ==
                            notification_entity.TypeNotification.temperature
                        ? "assets/icons/temperature.svg"
                        : widget.notification.type ==
                                notification_entity.TypeNotification.humidity
                            ? "assets/icons/humidity.svg"
                            : widget.notification.type ==
                                    notification_entity.TypeNotification.ammonia
                                ? "assets/icons/ammonia.svg"
                                : "assets/icons/chicken_weight.svg",
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 111,
                        child: Text(
                          widget.notification.title,
                          style: TextStyle(
                            color: black,
                            fontFamily: medium,
                            fontSize: kBodyLarge,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.notification.createdAt.timeAgo,
                        style: const TextStyle(
                          color: Color(0xFF777777),
                          fontSize: kBodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.notification.description,
                style: const TextStyle(
                  color: Color(0xFF626262),
                  fontFamily: light,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
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
        ));
  }
}
