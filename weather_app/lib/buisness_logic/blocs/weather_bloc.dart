import 'package:weather_app/data/models/weather_daily_api.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial());
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeather) {
      yield WeatherLoading();
      try {
          final WeatherModel weather = await repository.getWeatherForLocation(event._location);
          final WeatherDailyModel weatherDaily = await repository.getWeatherDailyForLatLon(weather.coord.lat , weather.coord.lon);
          yield WeatherLoaded(weather, weatherDaily);
      
      } catch (error) {
        yield WeatherNotLoaded(error);
      }
    }
  }

}