import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Worker/worker.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String temp = "";
  String hum = "";
  String air_speed = "";
  String des = "";
  String main = "";
  void startApp() async {
    worker instance = worker(location: "Bhavnagar");
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed": air_speed,
        "des_value": des,
        "main": main
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/weather-app.png",
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Weather App",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Made By Ujas",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            SpinKitSpinningLines(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
