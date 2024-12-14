import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicleapp/providers/vechile_details_provider.dart';
import 'package:intl/intl.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final totalVehicleProvider =
      Provider.of<GetVehicleDetailsProvider>(context, listen: false);
      totalVehicleProvider.getVehicleDetails();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Total Vehicle"),
      ),
      body: Consumer<GetVehicleDetailsProvider>(
        builder: (context, totalVehicleProvider, child) {
          return RefreshIndicator(
            onRefresh: () async {
              // You can trigger a refresh here if needed
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: vehicle.images!.map<Widget>((image) {
                            return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(image.imageUrl),
                                Text(vehicle.vehicleModel.name.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Text(vehicle.price.toString()),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(Icons.pedal_bike, size: 16), // Calendar icon
                                          const SizedBox(width: 8),
                                          Text(vehicle.fuelType.name),
                                          const Icon(Icons.timelapse, size: 16), // Calendar icon
                                          const SizedBox(width: 8),
                                          Text(vehicle.kmDriven.toString())
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          }).toList(),
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
