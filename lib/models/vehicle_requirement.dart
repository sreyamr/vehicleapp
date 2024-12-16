class VehicleRequirement {
  final int vehicleTypeId;
  final int brandId;
  final int vehicleModelId;
  final int vehicleVariantId;
  final int transmissionId;
  final int fuelTypeId;
  final int vehicleColorId;
  final int year;

  VehicleRequirement({
    required this.vehicleTypeId,
    required this.brandId,
    required this.vehicleModelId,
    required this.vehicleVariantId,
    required this.transmissionId,
    required this.fuelTypeId,
    required this.vehicleColorId,
    required this.year,
  });

  // Add any necessary serialization logic for sending to API
  Map<String, dynamic> toJson() {
    return {
      'vehicle_type_id': vehicleTypeId,
      'brand_id': brandId,
      'vehicle_model_id': vehicleModelId,
      'vehicle_variant_id': vehicleVariantId,
      'transmission_id': transmissionId,
      'fuel_type_id': fuelTypeId,
      'vehicle_color_id': vehicleColorId,
      'year': year,
    };
  }
}
