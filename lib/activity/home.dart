import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    //print("This is a init state");
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    //print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Mumbai",
      "Chennai",
      "New Delhi",
      "Bangalore",
      "Hyderabad",
      "Ahmadabad",
      "Kolkata",
      "Jaipur"
    ];
    final _random = new Random();
// generate a random index based on the list length
// and use it to retrieve the element
    var ran_city = city_name[_random.nextInt(city_name.length)];
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    String temp = ((data['temp_value']).toString());
    String air = ((data['air_speed']).toString());
    if (temp == "NA") {
    } else {
      temp = ((data['temp_value']).toString()).substring(0, 4);
      air = ((data['air_speed']).toString()).substring(0, 4);
    }

    String icon = data['icon_value'];
    String city = data['city_value'];
    String hum = data['hum_value'];

    String des = data['des_value'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color.fromRGBO(0, 140, 255, 1),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  Color.fromRGBO(0, 140, 255, 1),
                  Color.fromARGB(255, 83, 114, 237),
                  Color.fromARGB(255, 80, 131, 241),
                  Color.fromARGB(255, 123, 166, 235),
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
                tileMode: TileMode.mirror,
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print("Please Enter City Name");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": searchController.text,
                                });
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $ran_city",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14)),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Image.network(
                                "https://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  "$des",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $city",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14)),
                        padding: EdgeInsets.all(26),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 80),
                                ),
                                Text(
                                  "°C",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14)),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.day_windy),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$air",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("km/h"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14)),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("% Percent"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made By Ujas"),
                      Text("Data Provided By https://openweathermap.org/"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
