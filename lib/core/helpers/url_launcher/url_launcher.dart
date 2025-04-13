import 'package:url_launcher/url_launcher.dart';

class LauncherHelper {
  static Future<void> launchUrlFromString(String url) async {
    try {
      final Uri uri = Uri.parse(url); // ✅ تحويل النص إلى `Uri`
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (e) {
      throw Exception('Error launching URL: $e');
    }
  }
}
