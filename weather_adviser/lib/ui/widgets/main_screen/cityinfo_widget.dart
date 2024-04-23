import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/ui/widgets/main_screen/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';
import 'package:weathet_app/ui/widgets/main_screen/barometer_widget.dart';

class CityInfoWidget extends StatelessWidget {
  const CityInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var city = snapshot!.location?.name;
    var temp = snapshot.current?.tempC!.round();
    var feelTemp = snapshot.current?.feelslikeC;
    var windDegree = snapshot.current?.windDegree;
    var conditiontext = snapshot.current!.condition!.text;
    var url =
        'https://${((snapshot.current!.condition!.icon).toString().substring(2)).replaceAll("64", "128")}';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$city',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(windDegree! / 360),
              child: const Icon(Icons.north, color: primaryColor, size: 24),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(url, scale: 1.2),
                const SizedBox(
                    width: 20), // Space between the icon and temperature
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$temp°',
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Feels like $feelTemp°',
                      style: TextStyle(
                        fontSize: 20,
                        color: darkGreyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '$conditiontext',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
