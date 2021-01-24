import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Previsão do tempo",
      home: Home(),
    ));

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
    

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=nova%20friburgo&units=imperial&appid=[Sua api key]");

    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windSpeed = result['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Clima agora em Nova Friburgo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Carregando...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Carregando...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperatúra"),
                    trailing: Text(
                      temp != null
                          ? temp.toString() + "\u00B0"
                          : "Carregando...",
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Clima"),
                    trailing: Text(
                      description != null
                          ? description.toString()
                          : "Carregando...",
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Umidade"),
                    trailing: Text(humidity != null
                        ? humidity.toString()
                        : "Carregando..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Velocidade do Vento"),
                    trailing: Text(windSpeed != null
                        ? windSpeed.toString()
                        : "Carregando..."),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
