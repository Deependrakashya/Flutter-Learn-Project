import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String wind = '';

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=Noida,Ind&appid=d88c156b70ec0c5b561740d2ff3b9d52'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  IconButton(onPressed: () {
                    setState(() {
                      getCurrentWeather();
                    });
                  }, icon: const Icon(Icons.refresh)))
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          double currentTemp = data['list'][0]['main']['temp'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final windSpeed = data['list'][0]['wind']['speed'];

          final allList = data['list'];

          currentTemp -= 273.15;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      child: ClipRRect(
                        // just for adding border radius
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '${currentTemp.toStringAsFixed(2)} °C',
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Icon(
                                  currentSky == 'Rain' || currentSky == 'Clouds'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 65,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  currentSky,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  const Text(
                    'Hourly Forecast',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 1; i < 10; i++)

                  //         HourlyForecast(
                  //           details: allList[i]['weather'][0]['description'].toString(),
                  //           time:allList[i]['dt_txt'].toString(),
                  //           temp: (allList[i]['main']['temp'] - 273.15).toStringAsFixed(2),
                  //         )
                  //     ],
                  //   ),
                  // ),

                  SizedBox(
                    height: 190,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        final hourlyForcast =
                            DateTime.parse(allList[index + 1]['dt_txt']);
                        final hCWeather =
                            allList[index + 1]['weather'][0]['main'];

                        return HourlyForecast(
                          details: allList[index + 1]['weather'][0]
                                  ['description']
                              .toString(),
                          time: DateFormat.Hm().format(hourlyForcast),
                          temp: (allList[index + 1]['main']['temp'] - 273.15)
                              .toStringAsFixed(2),
                          icon: hCWeather == 'Rain' || hCWeather == 'Clouds'
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // detailed card
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoWidget(
                          name: "Humidity",
                          iconName: Icons.water_drop,
                          value: '$currentHumidity%'),
                      AdditionalInfoWidget(
                          name: "Wind Speed",
                          iconName: Icons.air,
                          value: '$windSpeed m/s'),
                      AdditionalInfoWidget(
                          name: "Pressure",
                          iconName: Icons.add_reaction,
                          value: '$currentPressure hPa'),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  final String time;
  final String details;
  final String temp;
  final IconData icon;

  const HourlyForecast(
      {super.key,
      required this.time,
      required this.details,
      required this.temp,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),

      // width: 100,
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                time,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text('$temp°C'),
              const SizedBox(
                height: 10,
              ),
              Text(details),
            ],
          ),
        ),
      ),
    );
  }
}

class AdditionalInfoWidget extends StatelessWidget {
  final IconData iconName;
  final String name;
  final String value;

  const AdditionalInfoWidget(
      {super.key,
      required this.name,
      required this.iconName,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Icon(iconName),
            const SizedBox(
              height: 10,
            ),
            Text(name),
            Text(value)
          ],
        ),
      ),
    );
  }
}
