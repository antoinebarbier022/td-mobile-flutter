import 'package:weather_app/data/dataproviders/weather_api.dart';
import 'package:weather_app/data/models/weather_daily_api.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherRepository{
  final WeatherAPI api;

  WeatherRepository(this.api);

  // Fonction qui permet de prendre les données brut pour les mettres dans le modèle
  Future<WeatherModel> getWeatherForLocation(String location) async {
    final String rawWeather = await api.getRawWeather(location);
    final WeatherModel weather = weatherModelFromJson(rawWeather);
    return  weather;
  }

    Future<WeatherDailyModel> getWeatherDailyForLatLon(double lat, double lon) async {
    final String rawWeatherDaily = await api.getRawWeatherDaily(lat, lon);
    final WeatherDailyModel weatherDaily = weatherDailyModelFromJson(rawWeatherDaily);
    return  weatherDaily;
  }
}