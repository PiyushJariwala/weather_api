import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'model/finalweather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List city_name = [
    'Surat',
    'Tokyo',
    'Ankara',
    'Abu dhabi',
    'London',
    'Washington',
    'Madrid',
    'Moscow',
    'Berlin',
    'Helsinki',
    'New York',
  ];
  List pin = [
    '2295405',
    '1118370',
    '2343732',
    '1940345',
    '44418',
    '2514815',
    '766273',
    '2122265',
    '638242',
    '565346',
    '2459115',
  ];

  int i = 0;

  dynamic weathericon = FaIcon(
    FontAwesomeIcons.cloudRain,
    color: Colors.white,
  );

  ModelData data = ModelData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    city_name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          title: Text("${city_name[i]}"),
          actions: [
            Icon(Icons.location_on),
          ],
        ),
        drawer: Drawer(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1617142020713-52989920e411?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGNsZWFyJTIwc2t5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60"),
                  fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 300,
                  color: Colors.blue.shade300,
                  alignment: Alignment.center,
                  child: Text(
                    "City",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                    height: 500,
                    width: 300,
                    child: ListView.builder(
                      itemCount: city_name.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              i = index;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: 275,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 2, color: Colors.white70)),
                            child: Text(
                              "${city_name[index]}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder(
            future: weatherApiCall(pin[i]),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print("======= ${snapshot.error}");
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                ModelData modelData = snapshot.data;
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          weatherImage(modelData
                              .consolidatedWeather![0].weatherStateName),
                        ),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          border: Border.all(width: 5, color: Colors.white70),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${modelData.parent!.title}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                    FontAwesomeIcons.temperatureThreeQuarters,
                                    size: 75),
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "${modelData.consolidatedWeather![0].theTemp!.toInt()}",
                                        style: TextStyle(fontSize: 75),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 50),
                                        child: Text(
                                          "◦ ",
                                          style: TextStyle(fontSize: 50),
                                        ),
                                      ),
                                      Text(
                                        "c",
                                        style: TextStyle(fontSize: 75),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.wind),
                                    Text(
                                      ' ${modelData.consolidatedWeather![0].windSpeed!.ceilToDouble()} Km/h',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    weatherIcon(modelData
                                        .consolidatedWeather![0]
                                        .weatherStateName),
                                    Text(
                                      "${modelData.consolidatedWeather![0].weatherStateName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${modelData.consolidatedWeather![0].applicableDate}",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "High : ${modelData.consolidatedWeather![0].minTemp!.toInt()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Low : ${modelData.consolidatedWeather![0].maxTemp!.toInt()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: modelData.consolidatedWeather!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 60,
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${modelData.consolidatedWeather![index].applicableDate}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "${modelData.consolidatedWeather![index].weatherStateName}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    weatherIcon(modelData
                                        .consolidatedWeather![index]
                                        .weatherStateName),
                                    Text(
                                      "${modelData.consolidatedWeather![index].theTemp!.toInt()} c",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }

  Future<ModelData> weatherApiCall(String pincoad) async {
    Uri url = Uri.parse("https://www.metaweather.com/api/location/${pincoad}/");
    var respons = await http.get(url);
    var _jsdata = convert.jsonDecode(respons.body);

    return ModelData.fromJson(_jsdata);
  }

  dynamic weatherImage(dynamic weather_type) {
    if (weather_type == 'Snow') {
      return "https://images.unsplash.com/photo-1551582045-6ec9c11d8697?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHNub3d8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60";
    } else if (weather_type == 'Sleet') {
      return "https://images.unsplash.com/photo-1444384851176-6e23071c6127?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8c2xlZXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60";
    } else if (weather_type == 'Hail') {
      return "https://images.unsplash.com/photo-1566205190430-536f5c93d8ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8aGFpbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60";
    } else if (weather_type == 'Thunderstorm') {
      return "https://images.unsplash.com/photo-1551234250-d88208c2ce14?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHRodW5kZXJzdG9ybXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60";
    } else if (weather_type == 'Heavy Rain') {
      return "https://images.unsplash.com/photo-1501999635878-71cb5379c2d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8aGVhdnklMjByYWlufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60";
    } else if (weather_type == 'Light Rain') {
      return "https://images.unsplash.com/photo-1503429134808-fdf0cd4e1bfa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGxpZ2h0JTIwcmFpbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60";
    } else if (weather_type == 'Showers') {
      return "https://images.unsplash.com/photo-1578185926358-7e064647af0c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cmFpbmJvd3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60";
    } else if (weather_type == 'Heavy Cloud') {
      return "https://images.unsplash.com/photo-1534088568595-a066f410bcda?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aGVhdnklMjBjbG91ZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60";
    } else if (weather_type == 'Light Cloud') {
      return "https://images.unsplash.com/photo-1644880878516-9674d4b520b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bGlnaHQlMjBjbG91ZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60";
    } else {
      return "https://images.unsplash.com/photo-1617142020713-52989920e411?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGNsZWFyJTIwc2t5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60";
    }
  }

  dynamic weatherIcon(dynamic weather_icon) {
    if (weather_icon == 'Snow') {
      weathericon = FaIcon(
        FontAwesomeIcons.snowflake,
        color: Colors.white,
      );
      return weathericon;
    } else if (weather_icon == 'Sleet') {
      weathericon = FaIcon(
        FontAwesomeIcons.snowflake,
        color: Colors.white,
      );
      return weathericon;
    } else if (weather_icon == 'Hail') {
      weathericon = FaIcon(
        FontAwesomeIcons.snowflake,
        color: Colors.white,
      );
      return weathericon;
    } else if (weather_icon == 'Thunderstorm') {
      weathericon = FaIcon(
        FontAwesomeIcons.cloudBolt,
      );
      return weathericon;
    } else if (weather_icon == 'Heavy Rain') {
      weathericon = FaIcon(
        FontAwesomeIcons.cloudShowersHeavy,
        color: Colors.grey.shade400,
      );
      return weathericon;
    } else if (weather_icon == 'Light Rain') {
      weathericon = FaIcon(
        FontAwesomeIcons.cloudRain,
        color: Colors.grey.shade400,
      );
      return weathericon;
    } else if (weather_icon == 'Showers') {
      weathericon = FaIcon(
        FontAwesomeIcons.rainbow,
        color: Colors.amber.shade300,
      );
      return weathericon;
    } else if (weather_icon == 'Heavy Cloud') {
      weathericon = FaIcon(
        FontAwesomeIcons.cloud,
        color: Colors.blue,
      );
      return weathericon;
    } else if (weather_icon == 'Light Cloud') {
      weathericon = FaIcon(
        FontAwesomeIcons.cloudSun,
        color: Colors.amber,
      );
      return weathericon;
    } else {
      weathericon = Icon(
        Icons.wb_sunny,
        color: Colors.orange,
      );
      return weathericon;
    }
  }
}
