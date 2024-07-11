extension StringExt on String {
  String imageUrl() {
    String url = replaceAll(RegExp(r'[\[\]"]'), '');
    return url;
  }
}
