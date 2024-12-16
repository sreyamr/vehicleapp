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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("What would you prefer to have"),
      ),
      body: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, AppRoutes.addRequirement,arguments:vehicle );
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Card(
            color: Colors.white,
            elevation: 1,
             child: SizedBox(
               height: 100,
                 width: 100,
                  child:Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Center(child: Icon(Icons.car_crash,size: 35,)),
                        ),
                        Text(vehicle!.vehicleType.name)
                      ],
                    )
                )
            ),
        ),
      ),
    );
  }
}
