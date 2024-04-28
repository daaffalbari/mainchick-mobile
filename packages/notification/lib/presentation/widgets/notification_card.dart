import 'package:core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/date_extension.dart';
import 'package:notification/domain/entities/notification.dart'
    as notification_entity;
import 'package:notification/presentation/pages/notification_detail_page.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(this.notification, {Key? key}) : super(key: key);

  final notification_entity.Notification notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: notification.isRead ? const Color(0xFFFFEFDD) : white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            NotificationDetailPage.routeName,
            arguments: notification,
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                notification.type ==
                        notification_entity.TypeNotification.temperature
                    ? "assets/icons/temperature.svg"
                    : notification.type ==
                            notification_entity.TypeNotification.humidity
                        ? "assets/icons/humidity.svg"
                        : notification.type ==
                                notification_entity.TypeNotification.ammonia
                            ? "assets/icons/ammonia.svg"
                            : "assets/icons/chicken_weight.svg",
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      color: black,
                      fontFamily: medium,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 135,
                    child: Text(
                      notification.description,
                      style: const TextStyle(
                        color: Color(0xFF626262),
                        fontFamily: light,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.createdAt.timeAgo,
                    style: const TextStyle(
                      color: Color(0xFF777777),
                      fontSize: kBodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
