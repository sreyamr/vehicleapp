import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicleapp/providers/add_requirement.dart';

import '../models/vehicle_model.dart';
import '../models/vehicle_requirement.dart';
import '../providers/brand_download.dart';
import '../providers/model_download.dart';
import '../providers/variant_download.dart';

class AddRequirementScreen extends StatefulWidget {
  final Vehicle vehicle;

  const AddRequirementScreen({super.key, required this.vehicle});

  @override
  _AddRequirementScreenState createState() => _AddRequirementScreenState();
}

class _AddRequirementScreenState extends State<AddRequirementScreen> {
  String? selectedBrand;
  String? selectedModel;
  String? selectedVariant;
  String? selectedYear = '2024'; // Default year
  String? selectedTransmission;
  String? selectedFuelType;
  String? selectedColor;

  int? selectedBrandId;
  int? selectedModelId;
  int? selectedVariantId;
  int? selectedFuelTypeId;
  int? selectedColorId;

  late BrandDownload brandProvider;
  late ModelDownload modelProvider;
  late VariantDownload variantProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      brandProvider = Provider.of<BrandDownload>(context, listen: false);
      brandProvider.getBrand(widget.vehicle);

      modelProvider = Provider.of<ModelDownload>(context, listen: false);
      modelProvider.getModel(widget.vehicle);

      variantProvider = Provider.of<VariantDownload>(context, listen: false);
      variantProvider.getVariant(widget.vehicle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Dropdown
              Consumer<BrandDownload>(
                builder: (context, brandProvider, child) {
                  return buildDropdownField(
                    'Brand',
                    'Select Brand',
                    brandProvider.brand.map((brand) {
                      return DropdownMenuItem<String>(
                        value: brand.name,
                        child: Text(
                          brand.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    selectedValue: selectedBrand,
                    onChanged: (value) {
                      setState(() {
                        selectedBrand = value;
                        selectedBrandId = brandProvider.brand
                            .firstWhere((brand) => brand.name == value)
                            .id; // Set the brand ID based on selection
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              // Model Dropdown
              Consumer<ModelDownload>(
                builder: (context, modelProvider, child) {
                  return buildDropdownField(
                    'Model',
                    'Select Model',
                    modelProvider.models.map((model) {
                      return DropdownMenuItem<String>(
                        value: model.name,
                        child: Text(
                          model.name.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    selectedValue: selectedModel,
                    onChanged: (value) {
                      setState(() {
                        selectedModel = value;
                        selectedModelId = modelProvider.models
                            .firstWhere((model) => model.name == value)
                            .id;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              // Variant Dropdown
              Consumer<VariantDownload>(
                builder: (context, variantProvider, child) {
                  return buildDropdownField(
                    'Variant',
                    'Select Variant',
                    variantProvider.variant.map((variant) {
                      return DropdownMenuItem<String>(
                        value: variant.name,
                        child: Text(
                          variant.name.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    selectedValue: selectedVariant,
                    onChanged: (value) {
                      setState(() {
                        selectedVariant = value;
                        selectedVariantId = variantProvider.variant
                            .firstWhere((variant) => variant.name == value)
                            .id;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              // Year Dropdown
              buildDropdownField(
                'Year',
                'Select Year',
                ['2020', '2021', '2022', '2023', '2024'].map((year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(
                      year,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                selectedValue: selectedYear,
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Transmission Section
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
                        backgroundColor: selectedTransmission == 'Automatic'
                            ? Colors.brown[900]
                            : Colors.grey[200],
                        foregroundColor: selectedTransmission == 'Automatic'
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedTransmission = 'Automatic';
                        });
                      },
                      child: const Text('Automatic'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTransmission == 'Manual'
                            ? Colors.brown[900]
                            : Colors.grey[200],
                        foregroundColor: selectedTransmission == 'Manual'
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedTransmission = 'Manual';
                        });
                      },
                      child: const Text('Manual'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Fuel Type Dropdown
              Consumer<VariantDownload>(
                builder: (context, variantProvider, child) {
                  return buildDropdownField(
                    'Fuel Type',
                    'Select Fuel Type',
                    variantProvider.fuelTypes.map((fuelType) {
                      return DropdownMenuItem<String>(
                        value: fuelType.name,
                        child: Text(
                          fuelType.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    selectedValue: selectedFuelType,
                    onChanged: (value) {
                      setState(() {
                        selectedFuelType = value;
                        selectedFuelTypeId = variantProvider.fuelTypes
                            .firstWhere((fuelType) => fuelType.name == value)
                            .id;
                      });
                    },
                  );
                },
              ),

              const SizedBox(height: 16),
              // Color Dropdown
              Consumer<BrandDownload>(
                builder: (context, brandProvider, child) {
                  return buildDropdownField(
                    'Color',
                    'Select color',
                    brandProvider.vehicleColor.map((color) {
                      return DropdownMenuItem<String>(
                        value: color.name,
                        child: Text(
                          color.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    selectedValue: selectedColor,
                    onChanged: (value) {
                      setState(() {
                        selectedColor = value;
                        selectedColorId = brandProvider.vehicleColor
                            .firstWhere((color) => color.name == value)
                            .id;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 32),
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[900],
                  ),
                  onPressed: _submitRequirement,

                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dropdown Field Builder
  Widget buildDropdownField(
      String label, String hint, List<DropdownMenuItem<String>> items,
      {String? selectedValue, required Function(String?) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: items,
          onChanged: onChanged,
          hint: Text(hint),
        ),
      ],
    );
  }


  void _submitRequirement() {
    final requirement = VehicleRequirement(
      vehicleTypeId: widget.vehicle.vehicleType.id,
      brandId: selectedBrandId ?? 0,
      vehicleModelId: selectedModelId ?? 0,
      vehicleVariantId: selectedVariantId ?? 0,
      transmissionId: selectedTransmission == 'Automatic' ? 1 : 2,
      fuelTypeId: selectedFuelTypeId ?? 0,
      vehicleColorId: selectedColorId ?? 0,
      year: int.parse(selectedYear ?? '2024'),
    );

    final addRequirementProvider = Provider.of<AddRequirement>(context, listen: false);
    addRequirementProvider.addRequirement(requirement).then((_) {
      if (addRequirementProvider.addSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vehicle requirement created')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add requirement')));
      }
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    });
  }
}
