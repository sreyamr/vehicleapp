import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../config/app_controller.dart';
import '../models/transmission_model.dart';
import '../models/vehicle_model.dart';
import '../utlis/urls.dart';

class VariantDownload with ChangeNotifier {
  List<VehicleVariant> _variant = [];
  List<FuelType> _fuelTypes = [];
  List<Transmission> _transMission = [];
  bool _isLoading = false;

  List<VehicleVariant> get variant => _variant;
  List<FuelType> get fuelTypes => _fuelTypes;
  List<Transmission> get transMission => _transMission;
  bool get isLoading => _isLoading;

  Future<void> getVariant(Vehicle vehicle) async {
    final url = Uri.parse(
        "${Urls.getVariant}${vehicle.vehicleType.id}/${vehicle.brand.id}/${vehicle.vehicleModel.id}");
    print(url);
    String? token = await AppController.getToken();
    print(token);

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("variant: $data");

        // Parse variants
        _variant = (data['data']['variant'] as List)
            .map((e) => VehicleVariant.fromJson(e))
            .toList();

        // Parse fuel types
        _fuelTypes = (data['data']['fuelTypes'] as List)
            .map((e) => FuelType.fromJson(e))
            .toList();

        // _transMission = (data['data']['transmission'] as List)
        //     .map((e) => Transmission.fromJson(e))
        //     .toList();

      } else {
        print('variant download failed: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}



