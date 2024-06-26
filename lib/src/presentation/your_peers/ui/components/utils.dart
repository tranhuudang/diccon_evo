String extractFileName(String url) {
  // Extract the part after the last '%2F' and before the '?' or the end of the string
  String encodedPath = url.split('/').last.split('?').first;
  String decodedPath = Uri.decodeComponent(encodedPath);
  return decodedPath.split('/').last;
}