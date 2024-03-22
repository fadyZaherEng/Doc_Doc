import 'package:country_ip/country_ip.dart';
import 'package:flutter/material.dart';

class CountryIpWidget extends StatefulWidget {
  const CountryIpWidget({super.key});

  @override
  State<CountryIpWidget> createState() => _CountryIpWidgetState();
}

class _CountryIpWidgetState extends State<CountryIpWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country IP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Country IP',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () async {
                final countryIpResponse = await CountryIp.find();

                print("countryIpResponse : $countryIpResponse");
                // countryIpResponse : CountryResponse(country: United States, countryCode: US, ip: 9.9.9.9)
                print(
                    "User's country code : ${countryIpResponse?.countryCode}");
                // User's country code : US
                print("User's country : ${countryIpResponse?.country}");
                // User's country : United States
                print("User's ip : ${countryIpResponse?.ip}");
                // User's ip : 9.9.9.9

                // Find country of a specified IP
                // IPv4
                final countryIpResponse2 =
                    await CountryIp.findFromIP('9.9.9.9');

                // Find country of local device
                final countryIpResponse5 = await CountryIp.find();

                print("countryIpResponse : $countryIpResponse2");
                // countryIpResponse : CountryResponse(country: United States, countryCode: US, ip: 9.9.9.9)
                print(
                    "User's country code : ${countryIpResponse2?.countryCode}");
                // User's country code : US
                print("User's country : ${countryIpResponse2?.country}");
                // User's country : United States
                print("User's ip : ${countryIpResponse2?.ip}");
                // User's ip : 9.9.9.9

                // IPv6
                final countryIpResponse3 =
                    await CountryIp.findFromIP('::ffff:909:909');

                print("countryIpResponse : $countryIpResponse3");
                // countryIpResponse : CountryResponse(country: United States, countryCode: US, ip: ::ffff:909:909)
                print(
                    "User's country code : ${countryIpResponse3?.countryCode}");
                // User's country code : US
                print("User's country : ${countryIpResponse3?.country}");
                // User's country : United States
                print("User's ip : ${countryIpResponse3?.ip}");
              },
              child: const Text('Get Country IP'),
            ),
          ],
        ),
      ),
    );
  }
}
