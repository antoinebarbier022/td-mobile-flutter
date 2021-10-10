part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {
  @override
  String toString() => 'WeatherLoading';
}

class WeatherLoading extends WeatherState {
  @override
  String toString() => 'WeatherLoading';
}

class WeatherLoaded extends WeatherState {
  final WeatherModel _weather;
  final WeatherDailyModel _weatherDaily;

  WeatherLoaded(this._weather, this._weatherDaily);
  
  WeatherModel get getWeather => _weather;
  WeatherDailyModel get getWeatherDaily => _weatherDaily;
  

  List<Object> get props => [_weather, _weatherDaily];

  @override
  String toString() => 'WeatherLoaded';
}


class WeatherNotLoaded extends WeatherState {
  final Object _error;

  WeatherNotLoaded(this._error);
  Object get getError => _error;

  List<Object> get props => [_error];

  @override
  String toString() => 'WeatherNotLoaded';
}

