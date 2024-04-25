import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/constants.dart';
import 'package:core/presentation/widgets/cutom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:notification/domain/entities/notification.dart'
    as notificationEntity;
import 'package:notification/presentation/widgets/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  static const routeName = '/notification';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> myTabs = [
    Tab(text: 'All'),
    Tab(text: 'Unread'),
    Tab(text: 'Read'),
  ];

  final List<notificationEntity.Notification> _notifications = [
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.temperature,
      title: 'Today you have not given feed',
      description: 'Please do the feeding in cages 1  before the time ends',
      createdAt: DateTime.now().subtract(const Duration(minutes: 24)),
      isRead: true,
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.humidity,
      title: 'Unstable Humidity',
      description:
          'Cage 2 Block 1 and Cage 1 Block 3 has a temperature of 68.89°C',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.humidity,
      title: 'Excess ammonia content',
      description:
          'Cage 2 Block 1 and Cage 1 Block 3 has a temperature of 68.89°C',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      isRead: true,
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.chicken,
      title: 'Harvest time',
      description: "It's time to harvest in cage 1 block 3",
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      isRead: true,
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.humidity,
      title: 'Unstable Humidity',
      description:
          'Cage 2 Block 1 and Cage 1 Block 3 has a temperature of 68.89°C',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.humidity,
      title: 'Unstable Humidity',
      description:
          'Cage 2 Block 1 and Cage 1 Block 3 has a temperature of 68.89°C',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];

  final List<notificationEntity.Notification> _unreadNotifications = [
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.humidity,
      title: 'Unstable Humidity',
      description:
          'Cage 2 Block 1 and Cage 1 Block 3 has a temperature of 68.89°C',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.humidity,
      title: 'Unstable Humidity',
      description:
          'Cage 2 Block 1 and Cage 1 Block 3 has a temperature of 68.89°C',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.humidity,
      title: 'Unstable Humidity',
      description:
          'Cage 2 Block 1 and Cage 1 Block 3 has a temperature of 68.89°C',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];

  final List<notificationEntity.Notification> _readNotifications = [
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.temperature,
      title: 'Today you have not given feed',
      description: 'Please do the feeding in cages 1  before the time ends',
      createdAt: DateTime.now().subtract(const Duration(minutes: 24)),
      isRead: true,
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.humidity,
      title: 'Excess ammonia content',
      description:
          'Cage 2 Block 1 and Cage 1 Block 3 has a temperature of 68.89°C',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      isRead: true,
    ),
    notificationEntity.Notification(
      type: notificationEntity.TypeNotification.chicken,
      title: 'Harvest time',
      description: "It's time to harvest in cage 1 block 3",
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: myTabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const AppBarLeading(),
          title: const AppBarTitle(title: 'Notifications'),
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
              CustomTabBar(
                controller: _tabController,
                tabs: myTabs,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    ListView.separated(
                      padding: const EdgeInsets.only(top: 28),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return NotificationCard(notification);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
                    ListView.separated(
                      padding: const EdgeInsets.only(top: 28),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _unreadNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = _unreadNotifications[index];
                        return NotificationCard(notification);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
                    ListView.separated(
                      padding: const EdgeInsets.only(top: 28),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _readNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = _readNotifications[index];
                        return NotificationCard(notification);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
