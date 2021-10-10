part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {
  //final Weather weather;
  final _location;
  GetWeather(this._location);

  List<Object> get props => [_location];

  @override
  String toString() => 'GetWeather $_location';
}

class GetWeatherDaily extends WeatherEvent {
  //final Weather weather;
  final double _lon;
  final double _lat;
  GetWeatherDaily(this._lat, this._lon);

  List<Object> get props => [_lat, _lon];

  @override
  String toString() => 'GetWeatherDaily $_lat $_lon';
}


