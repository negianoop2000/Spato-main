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
    // Determine secondary color based on theme
    Color colorSecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;

    // Determine text colors based on theme
    bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    Color primaryTextColor = isLightTheme ? Colors.black : Colors.white;
    Color secondaryTextColor = isLightTheme ? Colors.grey[700]! : Colors.grey[400]!;

    // Seen status logic
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
                    style: TextStyle(
                      color: seenStatusInt == 1 ? primaryTextColor : secondaryTextColor,
                      fontSize: 16,
                      fontWeight: seenStatusInt == 1 ? FontWeight.bold : FontWeight.normal,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    notification.body,
                    style: TextStyle(
                      color: seenStatusInt == 1 ? primaryTextColor : secondaryTextColor,
                      fontSize: 14,
                      fontWeight: seenStatusInt == 1 ? FontWeight.bold : FontWeight.normal,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(notification.createdAt),
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 12,
                    ),
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

  // String _formatBodyText(String body) {
  //   String formattedBody = body.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
  //
  //   print('Original Body: $body');
  //   print('Formatted Body: $formattedBody');
  //
  //   return formattedBody;
  // }
}
