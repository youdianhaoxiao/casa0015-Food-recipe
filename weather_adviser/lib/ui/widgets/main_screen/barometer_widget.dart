import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/ui/widgets/main_screen/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';


class BarometerWidget extends StatelessWidget {
  const BarometerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var uv = snapshot!.current?.uv;
    var speed = snapshot.current?.windKph;
    var humidity = snapshot.current?.humidity;
    var pressure = snapshot.current?.pressureMb;
    var visKm = snapshot.current?.visKm;
    var co = snapshot!.current!.air_quality?.co?.toStringAsFixed(2);
    var no2 = snapshot.current!.air_quality?.no2?.toStringAsFixed(2);
    var o3 = snapshot.current!.air_quality?.o3?.toStringAsFixed(2);
    var pm2_5 = snapshot.current!.air_quality?.pm2_5?.toStringAsFixed(2);
    var pm10 = snapshot.current!.air_quality?.pm10?.toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: appText(
              size: 20,
              color: primaryColor.withOpacity(.8),
              text: 'AQI',
              isBold: FontWeight.bold,
            ),
          ),
          Card(
            // color: Colors.amber[50],
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: GridView.count(
              shrinkWrap:
                  true, // Add shrinkWrap to make GridView work inside Column
              crossAxisCount: 3, // Number of columns
              childAspectRatio: 1, // Aspect ratio of each cell
              children: [
                gridTile(icon: Icons.wb_sunny, label: 'UV', value: '$uv'),
                gridTile(
                    icon: Icons.water_drop_outlined,
                    label: 'Humidity',
                    value: '$humidity %'),
                gridTile(
                    icon: Icons.speed,
                    label: 'Pressure',
                    value: '$pressure hPa'),
                gridTile(
                    icon: Icons.lens_blur,
                    label: 'Visibility',
                    value: '$visKm Km'),
                gridTile(
                    icon: Icons.air,
                    label: 'Wind Speed',
                    value: '$speed km/h',
                    additionalText: snapshot.current!.windDir!),
                gridTile(icon: Icons.opacity, label: 'CO', value: '$co μg/m3'),
                gridTile(
                    icon: Icons.format_color_reset,
                    label: 'NO2',
                    value: '$no2 μg/m3'),
                gridTile(
                    icon: Icons.water_drop, label: 'O3', value: '$o3 μg/m3'),
                gridTile(
                    icon: Icons.masks, label: 'PM2.5', value: '$pm2_5 μg/m3'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget gridTile(
      {required IconData icon,
      required String label,
      required String value,
      String? additionalText}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue),
        Text(label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 12)),
        if (additionalText != null)
          Text(additionalText,
              style: TextStyle(fontSize: 12)), // Optional additional text
      ],
    );
  }
}
