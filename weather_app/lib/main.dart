import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/buisness_logic/blocs/weather_bloc.dart';
import 'package:weather_app/data/dataproviders/weather_api.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/presentation/pages/home_page.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(10, 14, 56, 1),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold,),
          headline2: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          headline3: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w200),
          headline4: TextStyle(color: Colors.white,),
          headline5: TextStyle(color: Colors.white,),
          headline6: TextStyle(color: Colors.white,),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
        
      ),
      home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(WeatherRepository(WeatherAPI())),
            child:const MyHomePage(title: 'Weather App'),
            )
    );
  }
}
