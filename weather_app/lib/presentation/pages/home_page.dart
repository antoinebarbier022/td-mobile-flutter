import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/buisness_logic/blocs/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/show_weather_city_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
 

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    const String location = "Montpellier";
    weatherBloc.add(GetWeather(location));

    final controllerLocation = TextEditingController();
    

    

    return Scaffold(
        
        /*appBar: AppBar(
          title: Text(title),
          automaticallyImplyLeading: false,
          actions:[
            IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            )
          ],
        ),*/
        body: SingleChildScrollView(
                child: Column(
                  children: [
                  const SizedBox(height: 30,),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child:  TextField(
                      controller: controllerLocation,
                      
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(

                        enabledBorder: const UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.white),   
                          ),  
                        
                        filled: true,
                        
                        hintText: "Entrer une ville",
                        hintStyle: TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if(controllerLocation.text == ""){
                              weatherBloc.add(GetWeather("Montpellier"));
                            }else{
                              weatherBloc.add(GetWeather(controllerLocation.text));
                            }
                            
                          },
                          icon: Icon(Icons.search),
                          color: Colors.white,
                      ),
                    ),
                  ),),
                 
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state){
                    if(state is WeatherLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }else if(state is WeatherLoaded){
                      return 
                        ShowWeatherCityWidget(weather: state.getWeather, weatherDaily: state.getWeatherDaily, city: location,);  
                    }else if(state is WeatherNotLoaded){
                      return const Center(
                      child:Text("Aucun résultats"));
                    }
                    return const Center(
                      child:Text("Aucun résultats"));
                  },
            )])));
  }
}
