extension DoubleExtension on double {
  String toFixed(int fractionDigits) {
    return toStringAsFixed(fractionDigits)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }
}
