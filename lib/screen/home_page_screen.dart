import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_cuaca/provider/cuaca_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../class/cuaca_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _selectedCity = 'Surabaya';


  final double lat =-6.200000;
  final double lon = 106.816666;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CuacaProvider>(context, listen: false)
          .showWeatherData(lat,lon);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String getMonthName(int month) {
      const List<String> monthNames = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return monthNames[month - 1];
    }
    String formattedDate = "${now.day} ${getMonthName(now.month)} ${now.year}";

    //bool isSwitchOn = false;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF739EE8),
              Color(0xFF5D78E1),
              Color(0xFF5973DF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              Consumer<CuacaProvider>(
                builder: (context, provider, child) {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${provider.cuacaModel.list ?? ""}, Indonesia",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Switch(
                            //   value: isSwitchOn,
                            //   onChanged: (bool value) {
                            //     setState(() {
                            //       isSwitchOn = value;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Colors.white,
                              Color(0xFF5D78E1),
                              Colors.white
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            "${provider.cuacaModel.list?.first.main?.temp ?? 0}°",
                            style: const TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ImageFiltered(
                            imageFilter:
                            ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                            child: CachedNetworkImage(
                              imageUrl:
                              "https://openweathermap.org/img/w/${provider.cuacaModel.list?.first.weather?.first.icon?? ""}.png",
                              fit: BoxFit.contain,
                              placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: cardWeather(provider.cuacaModel.list??[])
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 150),
                                  child: cardWeatherToday(
                                      provider.cuacaModel.list?.firstOrNull?.wind?.speed ?? 0.0,
                                      provider.cuacaModel.list?.first.main?.humidity?? 0,
                                      provider.cuacaModel.list?.first.visibility??0),


                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget weatherItem(int index, WeatherList weatherList) {
    // Check if the weatherList has any weather items
    Weather? weather = weatherList.weather?.isNotEmpty ?? false ? weatherList.weather![0] : null;

    return Container(
      width: 100,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Item $index',
            style: TextStyle(color: Colors.black),
          ),
          // Display weather details if available
          if (weather != null) ...[
            Text(
              'Main: ${weather.main}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Description: ${weather.description}',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ],
      ),
    );
  }

  Widget cardWeather(List<WeatherList> weatherList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.00),
                topLeft: Radius.circular(16.00),
                bottomRight: Radius.zero,
                bottomLeft: Radius.zero)),
        margin: const EdgeInsets.symmetric(horizontal: 0.0),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 40.0, bottom: 1),
                        child: Text(
                          'Today',
                          style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(right: 16.0, top: 40, bottom: 1),
                        child: Text(
                          'Next 7 Day',
                          style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherList.length,
                  itemBuilder: (context, index) {
                    return weatherItem(index, weatherList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardWeatherToday(double speed, int humidity, int visibility) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: Colors.white,
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/1247/1247767.png'),
                    width: 50,
                    height: 50,
                  ),
                  Text("$speed km/h"),
                  const Text("Wind"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: NetworkImage(
                        'https://cdn-icons-png.freepik.com/512/9342/9342439.png'),
                    width: 50,
                    height: 50,
                  ),
                  Text("$humidity%"),
                  const Text("Humidity"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/4225/4225630.png'),
                    width: 50,
                    height: 50,
                  ),
                  Text("$visibility km"),
                  const Text("Visibility"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
