import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/ui/widgets/main_screen/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var time = DateTime.now().hour;

    return SizedBox(
      height: 100,
      child: Card(
        color: bgGreyColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 23,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            return Container(
              margin: index == time ? const EdgeInsets.only(left: 20) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    index < 11
                        ? appText(
                            size: 14,
                            text: '${index + 1} am',
                            color: primaryColor)
                        : index == 11
                            ? appText(
                                size: 14,
                                text: '${index + 1} pm',
                                color: primaryColor)
                            : appText(
                                size: 14,
                                text: '${index - 11} pm',
                                color: primaryColor),
                    const SizedBox(height: 10),
                    Image.network(
                        'https://${(snapshot!.forecast!.forecastday![0].hour![index].condition!.icon).toString().substring(2)}',
                        scale: 2),
                    const SizedBox(height: 5),
                    appText(
                      size: 14,
                      text:
                          '${snapshot.forecast!.forecastday![0].hour![index].tempC}°',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
