import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weather_daily_api.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/presentation/widgets/card_data_day_widget.dart';
import 'package:weather_app/presentation/widgets/data_element_widget.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/presentation/widgets/weather_image_widget.dart';

class ShowWeatherCityWidget extends StatelessWidget {
  ShowWeatherCityWidget({required this.weather, required this.weatherDaily, required this.city});

  WeatherModel weather;
  WeatherDailyModel weatherDaily;
  String city;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR', null);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 30),
        Text(
          weather.name,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        Text(DateFormat.yMMMMEEEEd('fr_FR').format(DateTime.fromMicrosecondsSinceEpoch(weather.dt  * 1000000)).toString(),
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: 40),
        SizedBox(
            height: 200,
            child: getWeatherImage(
                weatherDescription:
                    weather.weather.elementAt(0).main.toString(), dt: weather.dt, sunrise: weather.sys.sunrise, sunset: weather.sys.sunset, ),),
        //Text(weather.weather.elementAt(0).main.toString(),
            //style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DataElementWidget(
                title: "Température",
                data: (weather.main.temp - 273.15).toInt().toString(),
                type: "°C"),
            const SizedBox(
                height: 40, child: VerticalDivider(color: Colors.grey)),
            DataElementWidget(
                title: "Vent",
                data: (weather.wind.speed*3.6).toInt().toString(),
                type: "km/h"),
            const SizedBox(
                height: 40, child: VerticalDivider(color: Colors.grey)),
            DataElementWidget(
                title: "Humidité",
                data: weather.main.humidity.toString(),
                type: "%"),
          ],
        ),
        const SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          child: Text('Prochains jours',
              style: Theme.of(context).textTheme.headline2),
        ),
        Container(
          height: 200,
          alignment: Alignment.topLeft,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              CardDataDayWidget(weatherDaily: weatherDaily, index: 1,),
              CardDataDayWidget(weatherDaily: weatherDaily, index: 2,),
              CardDataDayWidget(weatherDaily: weatherDaily, index: 3,),
              CardDataDayWidget(weatherDaily: weatherDaily, index: 4,),
              CardDataDayWidget(weatherDaily: weatherDaily, index: 5,),
              CardDataDayWidget(weatherDaily: weatherDaily, index: 6,),
              CardDataDayWidget(weatherDaily: weatherDaily, index: 7,),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Text("Dernière mise à jour : ${DateFormat.Hm('fr_FR').format(DateTime.fromMicrosecondsSinceEpoch(weather.dt  * 1000000)).toString()}", style: TextStyle(fontSize: 12 ,fontWeight: FontWeight.bold, color: Colors.grey[400]))
      ],
    );
  }
}
