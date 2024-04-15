import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SportsPage extends StatelessWidget {
  const SportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(249, 247, 188, 241),
        title: const Text('Life Indicies'),
      ),
      body: Center(
        child: SportsWidget(),
      ),
    );
  }
}

//class SportsWidget extends StatefulWidget {
//   @override
//   _SportsWidgetState createState() => _SportsWidgetState();
// }

// class _SportsWidgetState extends State<SportsWidget> {
//   List<dynamic> _sports = [];

//   Future<void> _fetchSports() async {
//     final response = await http.get(Uri.parse(
//         'https://api.weatherapi.com/v1/sports.json?key=8ff95441e89a44f4b4e184906232004&q=london'));

//     // if (response.statusCode == 200) {
//     //   final data = json.decode(response.body);
//     //   setState(() {
//     //     _sports = data.values.toList();
//     //   });
//     // } else {
//     //   throw Exception('Failed to load sports');
//     // }
//     final data = json.decode(response.body);
//     setState(() {
//       _sports = data.values.toList();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchSports();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView.builder(
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           final sportType = _sports[index].keys.toList().first;
//           final sportEvents = _sports[index][sportType];
//           final iconData = getIconData(sportType);

//           return Container(
//             margin: EdgeInsets.all(8.0),
//             padding: EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(iconData),
//                     SizedBox(width: 8.0),
//                     Text(
//                       sportType.toUpperCase(),
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 if (sportEvents.isEmpty)
//                   Text('No events for this sport')
//                 else
//                   ...sportEvents.map((event) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           event['tournament'],
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8.0),
//                         Text('${event['match']} @ ${event['stadium']}'),
//                         SizedBox(height: 8.0),
//                         Text(event['start']),
//                         SizedBox(height: 16.0),
//                       ],
//                     );
//                   }).toList(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   IconData getIconData(String sportType) {
//     switch (sportType) {
//       case 'football':
//         return Icons.sports_soccer;
//       case 'cricket':
//         return Icons.sports_cricket;
//       case 'golf':
//         return Icons.sports_golf;
//       default:
//         return Icons.sports;
//     }
//   }
// }

class SportsWidget extends StatefulWidget {
  const SportsWidget({Key? key}) : super(key: key);

  @override
  _SportsWidgetState createState() => _SportsWidgetState();
}

class _SportsWidgetState extends State<SportsWidget> {
  late List _sportsList;

  Future<List> fetchSports() async {
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/sports.json?key=8ff95441e89a44f4b4e184906232004&q=london'));
    final decoded = json.decode(response.body);
    return decoded.values.toList();
    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response, parse the JSON.
    //   final decoded = json.decode(response.body);
    //   return decoded.values.toList();
    // } else {
    //   // If the server did not return a 200 OK response, throw an error.
    //   throw Exception('Failed to load sports');
    // }
  }

  @override
  void initState() {
    super.initState();
    fetchSports().then((sportsList) {
      setState(() {
        _sportsList = sportsList;
      });
    });
  }

  Widget _buildSportCard(String sportType) {
    final sportData = _sportsList.firstWhere(
        (sport) => sportType.toLowerCase() == sport.keys.first.toLowerCase(),
        orElse: () => null);

    if (sportData == null || sportData.values.first.isEmpty) {
      return Container();
    }

    final List<Map<String, dynamic>> matches =
        List<Map<String, dynamic>>.from(sportData.values.first);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sportType.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: matches.length,
                itemBuilder: (BuildContext context, int index) {
                  final match = matches[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match['tournament'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        match['match'],
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '${match['start']} in ${match['stadium']}',
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _sportsList == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              _buildSportCard('Football'),
              _buildSportCard('Cricket'),
              _buildSportCard('Golf'),
            ],
          );
  }
}
