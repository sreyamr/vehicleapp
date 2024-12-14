import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicleapp/providers/get_requirement_provider.dart';
import 'package:vehicleapp/providers/login_provider.dart';
import 'package:vehicleapp/providers/total_vehicle_provider.dart';
import 'package:vehicleapp/providers/vechile_details_provider.dart';
import 'package:vehicleapp/screens/home_srceen.dart';
import 'package:vehicleapp/screens/login_screen.dart';
import 'package:vehicleapp/screens/requirement_screen.dart';
import 'package:vehicleapp/screens/splash_screen.dart';
import 'package:vehicleapp/screens/vechiledetails_screen.dart';

import 'config/approutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_)=>TotalVehicleProvider()),
        ChangeNotifierProvider(create: (_)=>GetVehicleDetailsProvider()),
        ChangeNotifierProvider(create: (_)=>GetRequirementProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: AppRoutes.splash,
        routes: getAppRoute(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }

  Map<String,WidgetBuilder> getAppRoute(){
    return{
      AppRoutes.splash:(context)=> const SplashScreen(),
      AppRoutes.login:(context)=>  LoginScreen(),
      AppRoutes.home:(context)=>  const HomeScreen(),
      AppRoutes.vehicleDetails:(context)=>  const VehicleDetailsScreen(),
      AppRoutes.requirement:(context)=>  const RequirementScreen()
    };
  }
}


