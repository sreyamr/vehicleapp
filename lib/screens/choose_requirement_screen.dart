import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/approutes.dart';
import '../models/vehicle_model.dart';

class ChooseRequirementScreen extends StatelessWidget {

  const ChooseRequirementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Vehicle? vehicle = ModalRoute.of(context)?.settings.arguments as Vehicle?;
    return  Scaffold(
      appBar: AppBar(
        title: const Text("What would you prefer to have"),
      ),
      body: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, AppRoutes.addRequirement,arguments:vehicle );
        },
        child: Card(
          elevation: 6,
           child: SizedBox(
             height: 100,
               width: 100,
                child:Column(
                    children: [
                      const Center(child: Icon(Icons.car_crash)),
                      Text(vehicle!.vehicleType.name)
                    ],
                  )
              )
          ),
      ),
    );
  }
}
