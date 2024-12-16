class Vehicle {
  final int? id;
  final String? uniqueId;
  final int? fkVehicleTypeId;
  final int? fkFuelTypeId;
  final int? fkBrandId;
  final int? fkVehicleModelId;
  final int? fkVehicleVariantId;
  final String? year;
  final String? price;
  final String? dealPrice;
  final int? isNewArrival;
  final int? isPopular;
  final String? vehicleStatus;
  final String? isVerified;
  final String? totalAmount;
  final String? createdAt;
  final String? location;
  final String? kmDriven;
  final int? listedDays;
  final bool? isBooked;
  final int? bookingId;
  final List<VehicleImage> images;
  final VehicleType vehicleType;
  final FuelType fuelType;
  final Brand brand;
  final VehicleModelName vehicleModel;
  final VehicleVariant vehicleVariant;
  final VehicleColor vehicleColor;

  Vehicle({
    required this.id,
    required this.uniqueId,
    required this.fkVehicleTypeId,
    required this.fkFuelTypeId,
    required this.fkBrandId,
    required this.fkVehicleModelId,
    required this.fkVehicleVariantId,
    required this.year,
    required this.price,
    required this.dealPrice,
    required this.isNewArrival,
    required this.isPopular,
    this.vehicleStatus,
    required this.isVerified,
    required this.totalAmount,
    required this.createdAt,
    required this.location,
    required this.kmDriven,
    required this.listedDays,
    required this.isBooked,
    required this.bookingId,
    required this.images,
    required this.vehicleType,
    required this.fuelType,
    required this.brand,
    required this.vehicleModel,
    required this.vehicleVariant,
    required this.vehicleColor
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as int?,
      uniqueId: json['unique_id'] as String?,
      fkVehicleTypeId: json['fk_vehicle_type_id'] as int?,
      fkFuelTypeId: json['fk_fuel_type_id'] as int?,
      fkBrandId: json['fk_brand_id'] as int?,
      fkVehicleModelId: json['fk_vehicle_model_id'] as int?,
      fkVehicleVariantId: json['fk_vehicle_variant_id'] as int?,
      year: json['year'] as String?,
      price: json['price'] as String?,
      dealPrice: json['deal_price'] as String?,
      isNewArrival: json['is_new_arrival'] as int?,
      isPopular: json['is_popular'] as int?,
      vehicleStatus: json['vehicle_status'] as String?,
      isVerified: json['is_verified'] as String?,
      totalAmount: json['total_amount'] as String?,
      createdAt: json['created_at'] as String?,
      location: json['location'] as String?,
      kmDriven: json['km_driven'] as String?,
      listedDays: json['listed_days'] as int?,
      isBooked: json['is_booked'] as bool?,
      bookingId: json['booking_id'] as int?,
      // Handle null values for images
      images: (json['images'] as List<dynamic>?)
          ?.map((image) => VehicleImage.fromJson(image as Map<String, dynamic>))
          .toList() ??
          [], // Use an empty list if null
      vehicleType: json['vehicle_type'] != null
          ? VehicleType.fromJson(json['vehicle_type'] as Map<String, dynamic>)
          : VehicleType(id: 0, name: ''), // Default if null
      fuelType: json['fuel_type'] != null
          ? FuelType.fromJson(json['fuel_type'] as Map<String, dynamic>)
          : FuelType(id: 0, name: ''), // Default if null
      brand: json['brand'] != null
          ? Brand.fromJson(json['brand'] as Map<String, dynamic>)
          : Brand(id: 0, name: ''), // Default if null
      vehicleModel: json['vehicle_model'] != null
          ? VehicleModelName.fromJson(json['vehicle_model'] as Map<String, dynamic>)
          : VehicleModelName(id: 0, name: ''), // Default if null
      vehicleVariant: json['vehicle_variant'] != null
          ? VehicleVariant.fromJson(json['vehicle_variant'] as Map<String, dynamic>)
          : VehicleVariant(id: 0, name: ''),
      vehicleColor: json['vehicleColors'] != null
          ? VehicleColor.fromJson(json['vehicleColors'] as Map<String, dynamic>)
          : VehicleColor(id: 0, name: ''), // Default if null
    );
  }



}

class VehicleColor {
  final int id;
  final String name;

  VehicleColor({required this.id, required this.name});

  factory VehicleColor.fromJson(Map<String, dynamic> json) {
  return VehicleColor(id: json['id'], name: json['name']);
  }
}


class VehicleImage {
  final int id;
  final int fkVehicleDetailsId;
  final String imageUrl;

  VehicleImage({
    required this.id,
    required this.fkVehicleDetailsId,
    required this.imageUrl,
  });

  factory VehicleImage.fromJson(Map<String, dynamic> json) {
    return VehicleImage(
      id: json['id'],
      fkVehicleDetailsId: json['fk_vehicle_details_id'],
      imageUrl: json['image_url'],
    );
  }
}

class VehicleType {
  final int id;
  final String name;

  VehicleType({required this.id, required this.name});

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(id: json['id'], name: json['name']);
  }
}

class FuelType {
  final int id;
  final String name;

  FuelType({required this.id, required this.name});

  factory FuelType.fromJson(Map<String, dynamic> json) {
    return FuelType(id: json['id'], name: json['name']);
  }
}

class Brand {
  final int id;
  final String name;

  Brand({required this.id, required this.name});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(id: json['id'], name: json['name']);
  }
}

class VehicleModelName {
  final int? id;
  final String? name;

  VehicleModelName({ this.id, this.name});

  factory VehicleModelName.fromJson(Map<String, dynamic> json) {
    return VehicleModelName(id: json['id'], name: json['name']);
  }
}

class VehicleVariant {
  final int? id;
  final String? name;

  VehicleVariant({ this.id, this.name});

  factory VehicleVariant.fromJson(Map<String, dynamic> json) {
    return VehicleVariant(id: json['id'], name: json['name']);
  }
}
