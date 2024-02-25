extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1, length - 1).toLowerCase()} ${substring(length - 1)}";
  }

  String getLastChar(int n) => substring(length - n);

  String removeLastChar() => substring(0, length - 1);

  removeTrailingZeros(String n) {
    return n.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  }
}
