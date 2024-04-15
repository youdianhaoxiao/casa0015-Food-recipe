//import 'package:dartx/dartx.dart';
// import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/ui/widgets/main_screen/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    final forecastdayList = snapshot!.forecast?.forecastday;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: appText(
              size: 20,
              color: primaryColor.withOpacity(.8),
              text: 'Weather forecast',
              isBold: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100,
            child: Card(
              color: bgGreyColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: forecastdayList!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final conditionIcon =
                      forecastdayList[index].day?.condition?.icon;
                  final tempC = forecastdayList[index].day?.avgtempC;
                  String label = '${index + 1}';

                  return Container(
                    width: MediaQuery.of(context).size.width / 3 -
                        40, // Divide the width to fit 3 items, adjust margins
                    margin: EdgeInsets.fromLTRB(index == 0 ? 20 : 10, 0,
                        index == forecastdayList.length - 1 ? 20 : 10, 0),
                    child: Card(
                      color: Color.fromARGB(255, 133, 151, 117),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appText(
                            size: 14,
                            text: label,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 10),
                          Image.network(
                            'https://${conditionIcon?.substring(2)}',
                            scale: 2,
                          ),
                          const SizedBox(height: 5),
                          appText(
                            size: 14,
                            text: '${tempC}°C',
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
