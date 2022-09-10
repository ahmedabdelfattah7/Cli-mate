import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppStates.dart';
import 'package:weathery/models/weather_model/weather_model.dart';
import 'package:weathery/services/local/cache_helper/cache_helper.dart';
import 'package:weathery/services/local/location_getter/location.dart';
import 'package:weathery/services/remote/http_helper/http_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  final openWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5';
  final apiKey = '0b268013a87c8b0fc4d7feab8cd47e93';
  WeatherModel weather = WeatherModel();

  int? temperature = 0;
  String? cityName = '';
  String? weatherIcon = '';
  String? weatherMassage = '';
  int? maxTemp = 0;
  int? minTemp = 0;
  String? main = '';
  int? sunrise;
  int? sunset;
  int? humidity;
  double? wind;
  dynamic currentWeather;
  Future<dynamic> getCurrentWeatherData() async {
    emit(LoadingWeatherData());
    Location location = Location();
    await location.getCurrentLocation();
    HttpHelper httpHelper = HttpHelper(
        url:
            '${openWeatherBaseUrl}/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await httpHelper.getData();
    debugPrint('this is weather data : $weatherData');
    currentWeather = weatherData;
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherData['name'];
    var condition = weatherData['weather'][0]['id'];
    weatherIcon = weather.getWeatherIcon(condition!);
    weatherMassage = weather.getMessage(temperature!);
    double tempMax = weatherData['main']['temp_max'];
    maxTemp = tempMax.toInt();
    double tempMin = weatherData['main']['temp_min'];
    minTemp = tempMin.toInt();
    main = weatherData['weather'][0]['main'];
    sunrise = weatherData['sys']['sunrise'];
    sunset = weatherData['sys']['sunset'];
    humidity = weatherData['main']['humidity'];
    wind = weatherData['wind']['speed'];

    emit(GetWeatherData());
  }

  Map<String, dynamic> listOfForecastCount = {};
  dynamic listOfForecast = [];
  dynamic listOfHourlyWeather = [];
  Future<dynamic> getFiveDaysForecast() async {
    emit(LoadingForecastData());
    Location location = Location();
    await location.getCurrentLocation();
    HttpHelper httpHelper = HttpHelper(
        url:
            '${openWeatherBaseUrl}/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric&cnt=7');
    dynamic forecastData = await httpHelper.getData();
    debugPrint('this is forecast data : $forecastData');

    listOfForecastCount = forecastData;
    listOfForecast = forecastData['daily'];
    listOfHourlyWeather = forecastData['hourly'];
    emit(GetForecastData());
    print(listOfForecastCount);
    print(listOfForecast);
    print('this is hour $listOfHourlyWeather');
  }



  String? cityMain = '';
  int? cityTemperature = 0;
  String? name = '';
  dynamic weatherCityIcon;
  dynamic cityWeather;
  Map<String, dynamic> weatherCityCounter={};
  int? maxCityTemp = 0;
  int? minCityTemp = 0;
  int? citySunrise;
  int? citySunset;
  int? cityHumidity;
  Future<dynamic> getCityWeather({String? cityName}) async {
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${apiKey}&units=metric';
    HttpHelper httpHelper = HttpHelper(url: url);
    var cityWeatherData = await httpHelper.getData();
    weatherCityCounter=cityWeatherData;
    cityWeather=cityWeatherData['weather'][0]['icon'];
    double temp = cityWeatherData['main']['temp'];
    cityTemperature = temp.toInt();
    name=cityWeatherData['name'];
    double tempMax = cityWeatherData['main']['temp_max'];
    maxCityTemp = tempMax.toInt();
    double tempMin = cityWeatherData['main']['temp_min'];
    minCityTemp = tempMin.toInt();
    cityMain=cityWeatherData['weather'][0]['main'];
    citySunrise=cityWeatherData['sys']['sunrise'];
    citySunset= cityWeatherData['sys']['sunset'];
    cityHumidity=cityWeatherData['main']['humidity'];
    emit(GetCityWeatherState());
    print(cityWeatherData);
 print(cityTemperature);
    return cityWeatherData;
  }
}
