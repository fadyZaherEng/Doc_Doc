import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}