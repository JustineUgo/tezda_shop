extension StringExt on String {
  String imageUrl() {
    String url = replaceAll(RegExp(r'[\[\]",]'), '').trim();
    return url;
  }
}
