import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../utils/constants/app_text_styles.dart';
import '../../../../utils/constants/colors.dart';
import '../../../data/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationItem({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorSecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;

    bool seenStatus = notification.seenStatus;
    int seenStatusInt = seenStatus ? 0 : 1;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getIconForType(notification.type, colorSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: seenStatusInt == 1
                        ? AppTextStyles.white16.copyWith(fontWeight: FontWeight.bold)
                        : AppTextStyles.grey16,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _formatBodyText(notification.body),
                    style: seenStatusInt == 1
                        ? AppTextStyles.white14.copyWith(fontWeight: FontWeight.bold)
                        : AppTextStyles.grey12,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(notification.createdAt),
                    style: AppTextStyles.grey12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconForType(String type, Color color) {
    switch (type) {
      case "review":
        return Icon(Icons.rate_review, color: color, size: 30);
      case "offer":
        return Icon(Icons.card_giftcard, color: color, size: 30);
      case "order":
        return Icon(Icons.shopping_cart, color: color, size: 30);
      case "coupon":
        return Icon(Icons.local_offer, color: color, size: 30);
      default:
        return Icon(Icons.notifications, color: color, size: 30);
    }
  }

  String _formatBodyText(String body) {
    String formattedBody = body.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();

    print('Original Body: $body');
    print('Formatted Body: $formattedBody');

    return formattedBody;
  }
}
