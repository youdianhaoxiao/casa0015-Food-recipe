import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(248, 54, 123, 219),
        title: const Text('Dress Advice'),
      ),
      body: Center(
        child: WeatherAdviceWidget(),
      ),
    );
  }
}

class WeatherAdviceWidget extends StatefulWidget {
  @override
  _WeatherAdviceWidgetState createState() => _WeatherAdviceWidgetState();
}

class _WeatherAdviceWidgetState extends State<WeatherAdviceWidget> {
  List<WeatherAdvice> advices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String lat = pos.latitude.toStringAsFixed(2);
      String lon = pos.longitude.toStringAsFixed(2);
      final response = await http.get(Uri.parse(
          'https://devapi.qweather.com/v7/weather/now?location=$lon,$lat&key=3750971dc4f04622ad1ee2f8757e16ae&lang=en'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int clouds = int.parse(data["now"]["cloud"]);
        double wind = double.parse(data["now"]["windSpeed"]);
        int temp = int.parse(data["now"]["temp"]);
        double rain = double.parse(data["now"]["precip"]);

        if (clouds < 20) {
          advices.add(WeatherAdvice(
              'It should be sunny, so sunglasses might be needed.\n',
              'assets/images/sunglasses.jpg'));
        } else {
          advices.add(WeatherAdvice('Cloudy day, so no sunglasses needed.\n',
              'assets/images/cloudy.jpg'));
        }
        if (wind > 30) {
          advices.add(WeatherAdvice(
              "There'll be wind, so a jacket might be useful.\n",
              'assets/images/wind.jpg'));
        } else if (wind > 10) {
          advices.add(WeatherAdvice(
              "There'll be a light breeze, so long sleeves might be useful.\n",
              'assets/images/breeze.jpg'));
        } else {
          advices.add(WeatherAdvice(
              "The air will be quite calm, so no need to worry about wind.\n",
              'assets/images/nowind.jpg'));
        }
        if (temp < 0) {
          advices.add(WeatherAdvice(
              "It's going to be freezing, so take a heavy coat.\n",
              'assets/images/freeze.jpg'));
        } else if (temp < 10) {
          advices.add(WeatherAdvice(
              "It's going to be cold, so a coat or thick jumper might be sensible\n",
              'assets/images/cold.jpg'));
        } else if (temp < 20) {
          advices.add(WeatherAdvice(
              "It's not too cold, but you might consider taking a light jumper.\n",
              'assets/images/lightcold.jpg'));
        } else {
          advices.add(WeatherAdvice(
              "Shorts and T-shirt weather! :)\n", 'assets/images/hot.jpg'));
        }
        if (rain == 0) {
          advices.add(WeatherAdvice(
              "It's not going to rain, so no umbrella is needed.\n",
              'assets/images/norain.jpg'));
        } else if (rain < 2.5) {
          advices.add(WeatherAdvice(
              "There'll be light rain, so consider a hood or umbrella.\n",
              'assets/images/lightrain.jpg'));
        } else if (rain < 7.5) {
          advices.add(WeatherAdvice(
              "There'll be moderate rain, so an umbrella is probably needed.\n",
              'assets/images/rain.jpg'));
        } else {
          advices.add(WeatherAdvice(
              "There'll be heavy rain, so you'll need an umbrella and a waterproof top.\n",
              'assets/images/heavyrain.jpg'));
        }
        // Add more conditions as necessary
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      setState(() {
        advices.add(
            WeatherAdvice('Failed to load weather data', 'assets/error.png'));
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: advices.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color.fromARGB(248, 143, 178, 223),
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            advices[index].advice,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Image.asset(
                            advices[index].imagePath,
                            fit: BoxFit.cover,
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

class WeatherAdvice {
  final String advice;
  final String imagePath;

  WeatherAdvice(this.advice, this.imagePath);
}
