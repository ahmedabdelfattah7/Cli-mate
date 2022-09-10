import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/presentation/screens/home_screen/home_screen.dart';
import 'package:weathery/presentation/screens/onboarding_screen/onboarding_screen.dart';

import 'package:weathery/services/local/cache_helper/cache_helper.dart';

import 'package:weathery/utils/constants/constants.dart';

import 'presentation/Manger/app_manger/bloc_observer.dart';
import 'presentation/Manger/app_manger/cubit_state.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  LocationPermission permission;
  permission= await Geolocator.requestPermission();
  if(permission==LocationPermission.denied){
    permission=await Geolocator.requestPermission();
    if(permission==LocationPermission.deniedForever){
      return Future.error('Location Not Available');
    }
  }
  if(!await Geolocator.isLocationServiceEnabled()){
    throw LocationServiceDisabledException();
  }

  bool? isDark = CacheHelper.readData(key: 'isDark');

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isDark: isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getCurrentWeatherData()
            ..getFiveDaysForecast()
        ),
        BlocProvider(
          create: (BuildContext context) =>
              ModeCubit()..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<ModeCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: kLightThemeData,
              darkTheme: kDarkThemeData,
              themeMode: ModeCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: OnBoardingScreen(),
            );
          }),
    );
  }
}
