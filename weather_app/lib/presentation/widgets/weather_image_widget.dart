 import 'package:flutter/cupertino.dart';

Widget getWeatherImage({required String weatherDescription, required int dt, required int sunrise, required int sunset, bool? alwaysDay}) {
    String state;
    if(alwaysDay != null){
      if(alwaysDay == true){
        state = 'day'; 
      }else{
        state = isNight(dt, sunrise, sunset) ? 'night' : 'day';
      }
    }else{
      state =  isNight(dt, sunrise, sunset) ? 'night' : 'day'; 
    }
    
     
    switch (weatherDescription) {
      case "Clear":
        return Image.asset("assets/images/${state}_clear.png");
      case "Clouds":
        return Image.asset("assets/images/${state}_cloud.png");
      case "Mist":
        return Image.asset("assets/images/${state}_mist.png");
      case "Rain":
        return Image.asset("assets/images/${state}_rain.png");
      case "Snow":
        return Image.asset("assets/images/${state}_snow.png");
      default:
        return Image.asset("assets/images/${state}_clear.png");
    }
  }

    bool isNight(dt, sunrise, sunset){
    int dtMin = DateTime.fromMicrosecondsSinceEpoch(dt  * 1000000).hour*60+ DateTime.fromMicrosecondsSinceEpoch(dt  * 1000000).minute;
    int sunriseMin = DateTime.fromMicrosecondsSinceEpoch(sunrise   * 1000000).hour*60+ DateTime.fromMicrosecondsSinceEpoch(sunrise   * 1000000).minute;
    int sunsetMin = DateTime.fromMicrosecondsSinceEpoch(sunset  * 1000000).hour*60+ DateTime.fromMicrosecondsSinceEpoch(sunset   * 1000000).minute;
    if(sunriseMin < dtMin  && dtMin < sunsetMin) {
      return false;
    } else{
      return true;
    }
  }