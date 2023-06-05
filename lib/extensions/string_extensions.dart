extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isNotEmpty) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
    return "";
  }
}
