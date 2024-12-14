import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicleapp/providers/get_requirement_provider.dart';

class RequirementScreen extends StatelessWidget {
  const RequirementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final getRequirementProvider =
      Provider.of<GetRequirementProvider>(context, listen: false);
      getRequirementProvider.getRequirement();
    });
    return Scaffold(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           Text(vehicle.fkVehicleVariantId.toString()),
                            Row(
                              children: [
                                Text("Brand"),
                                Text(vehicle.brand.name),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Vehicle Model"),
                                Text(vehicle.vehicleModel.name),
                              ],
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
