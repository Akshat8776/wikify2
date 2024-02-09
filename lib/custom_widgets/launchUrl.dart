import 'package:url_launcher/url_launcher.dart';

launch_url(url) async {
  if (!await launchUrl(Uri.parse(url.toString()))) {
    throw Exception('Could not launch $url');
  }
}
