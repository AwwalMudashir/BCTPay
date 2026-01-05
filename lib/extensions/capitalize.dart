extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String join(String text) => isNotEmpty ? "$this$text" : "";
}
