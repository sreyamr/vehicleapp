import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vehicle_model.dart';
import '../providers/brand_download.dart';

class AddRequirementScreen extends StatelessWidget {
  final Vehicle vehicle;

  const AddRequirementScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final totalVehicleProvider =
      Provider.of<BrandDownload>(context, listen: false);
      totalVehicleProvider.getBrand(vehicle); // Fetch brand data
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle requirement'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Consumer<BrandDownload>(
        builder: (context, brandProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDropdownField(
                    'Brand',
                    'Select Brand',
                    brandProvider.vehicle
                        .map((vehicle) => DropdownMenuItem<String>(
                      value: vehicle.brand.name,
                      child: Text(vehicle.brand.name,style: TextStyle(color: Colors.black),),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  buildDropdownField('Model', 'Select Model', []),
                  const SizedBox(height: 16),
                  buildDropdownField('Variant', 'Select Variant', []),
                  const SizedBox(height: 16),
                  buildDropdownField('Year', 'Select Year', []),
                  const SizedBox(height: 16),
                  const Text(
                    'Transmission *',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown[900],
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: const Text('Automatic'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: const Text('Manual'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildDropdownField('Fuel', 'Select fuel type', []),
                  const SizedBox(height: 16),
                  buildDropdownField('Color', 'Select Color', []),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[900],
                      ),
                      onPressed: () {},
                      child: const Text('Submit',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildDropdownField(
      String label, String hint, List<DropdownMenuItem<String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: items,
          onChanged: (value) {},
          hint: Text(hint),
        ),
      ],
    );
  }
}
