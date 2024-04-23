import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/ui/widgets/main_screen/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';
// import 'package:weathet_app/utils/ui.dart';
import 'package:weathet_app/ui/widgets/main_screen/header_widget.dart';
import 'carousel_widget.dart';
import 'barometer_widget.dart';
import 'package:weathet_app/ui/widgets/main_screen/cityinfo_widget.dart';
import 'package:weathet_app/ui/widgets/sub_pages/map_page.dart';
import 'package:weathet_app/ui/widgets/sub_pages/life_indicies_page.dart';
import '7forecast_widget.dart';
// import 'package:weathet_app/ui/widgets/sub_pages/sports_page.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MainScreenWidget(),
    FavoritePage(),
    //SportsPage(),
    // MapPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritePage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenModel>();

    return Scaffold(
      backgroundColor: Color.fromARGB(248, 143, 178, 223),
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Color.fromARGB(248, 54, 123, 219),
      ),
      body:
          model.forecastObject?.location?.name != null && model.loading == false
              ? _ViewWidget()
              : const Center(
                  child: SpinKitCubeGrid(
                      color: Color.fromARGB(255, 0, 0, 0), size: 80),
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Dresscode',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Map',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _ViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();

    return SafeArea(
      child: Stack(
        children: [
          model.forecastObject!.location!.name != 'Null'
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(height: 70),
                        CityInfoWidget(),
                        SizedBox(height: 15),
                        BarometerWidget(),
                        SizedBox(height: 15),
                        CarouselWidget(),
                        // SizedBox(height: 15),
                        // AQIWidget(),
                        SizedBox(height: 15),
                        ForecastWidget()
                      ]),
                )
              : Center(
                  child: appText(size: 16, text: '123'),
                ),
          const HeaderWidget(),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreenWidget();
  }
}
