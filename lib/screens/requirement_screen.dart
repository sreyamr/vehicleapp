import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicleapp/providers/get_requirement_provider.dart';

import '../config/approutes.dart';
import '../models/vehicle_model.dart';

class RequirementScreen extends StatelessWidget {
   RequirementScreen({super.key});

  @override
  late final Vehicle? vehicle;
   Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) async {
       final getRequirementProvider =
       Provider.of<GetRequirementProvider>(context, listen: false);
       await getRequirementProvider.getRequirement();
       vehicle = getRequirementProvider.vehicle.isNotEmpty
           ? getRequirementProvider.vehicle.first
           : null;
     });
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Requirement List"),
        backgroundColor: Colors.white
      ),
      body: Consumer<GetRequirementProvider>(
        builder: (context, totalVehicleProvider, child) {
          return RefreshIndicator(
            onRefresh: () async {
            },
            child: totalVehicleProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: totalVehicleProvider.vehicle.length,
              itemBuilder: (context, index) {
                final vehicle = totalVehicleProvider.vehicle[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text(vehicle.id.toString()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Fuel",style: TextStyle(color: Colors.grey),),
                                  Text(vehicle.fuelType.name),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Brand",style: TextStyle(color: Colors.grey),),
                                  Text(vehicle.brand.name),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Vehicle Model",style: TextStyle(color: Colors.grey)),
                                  Text(vehicle.vehicleModel.name.toString()),
                                ],
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
         child: ElevatedButton(onPressed: (){
           Navigator.pushNamed(context, AppRoutes.chooseRequirement,arguments:vehicle );
         },  style: ElevatedButton.styleFrom(
           backgroundColor: Colors.brown[900],
         ),
             child: const Text("Create Requirement",style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
