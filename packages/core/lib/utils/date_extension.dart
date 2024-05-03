extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }

  String get timeAgo {
    final Duration difference = DateTime.now().difference(this);
    String text = '';

    if (difference.inSeconds < 60) {
      text = 'Just now';
    } else if (difference.inMinutes < 60) {
      text =
          '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      text =
          '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      final int days = difference.inDays;
      text = '$days day${days == 1 ? '' : 's'} ago';
    }

    return text;
  }
}
