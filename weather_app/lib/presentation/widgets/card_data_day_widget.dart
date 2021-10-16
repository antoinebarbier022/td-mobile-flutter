import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weather_daily_api.dart';
import 'package:weather_app/presentation/widgets/weather_image_widget.dart';

class CardDataDayWidget extends StatelessWidget {
  CardDataDayWidget({required this.weatherDaily, required this.index});

  int index;
  WeatherDailyModel weatherDaily;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 160,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                DateFormat.MMMEd('fr_FR')
                    .format(DateTime.fromMicrosecondsSinceEpoch(
                        weatherDaily.daily[index].dt * 1000000))
                    .toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 70,
              child: getWeatherImage(
                  weatherDescription: weatherDaily.daily[index].weather
                      .elementAt(0)
                      .main
                      .toString(),
                  dt: weatherDaily.daily[index].dt,
                  sunrise: weatherDaily.daily[index].sunrise,
                  sunset: weatherDaily.daily[index].sunset,
                  alwaysDay: true),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          children: [
                            const Icon(
                              Icons.arrow_circle_up,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                                "${(weatherDaily.daily[index].temp.day - 273.15).toInt().toString()}°",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200])),
                          ],
                        ),
                        Wrap(
                          children: [
                            const Icon(
                              Icons.arrow_circle_down,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                                "${(weatherDaily.daily[index].temp.night - 273.15).toInt().toString()}°",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200])),
                          ],
                        ),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Wrap(
                          children: [
                            const Icon(
                              Icons.water,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                                "${weatherDaily.daily[index].humidity.toString()}%",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200])),
                          ],
                        ),
                        Wrap(
                          children: [
                            const Icon(
                              Icons.air,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                                "${(weatherDaily.daily[index].windSpeed * 3.6).toInt()}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200])),
                            Text("km/h",
                                style: TextStyle(
                                    height: 1.5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200])),
                          ],
                        )
                      ]),
                ],
              ),
            )
          ],
        ));
  }
}
