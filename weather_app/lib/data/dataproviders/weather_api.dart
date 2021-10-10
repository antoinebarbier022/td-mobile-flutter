import 'dart:ffi';

import 'package:http/http.dart' as http;
// an API for this app

// get the raw weather
class WeatherAPI{
  String apiKey = "47e13abe159798f46dc565b0ba58dbd6";

  Future<String> getRawWeather(String city) async{
    http.Response response = await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey"));
    if(response.statusCode != 200 ) throw Exception();
    return response.body;
  }

  Future<String> getRawWeatherDaily(double lat, double lon) async{
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,alerts,minutely&appid=$apiKey"));
    if(response.statusCode != 200 ) throw Exception();
    return response.body;
  }


}