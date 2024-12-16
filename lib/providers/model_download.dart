import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vehicleapp/models/vehicle_model.dart';
import '../config/app_controller.dart';
import '../utlis/urls.dart';

class ModelDownload with ChangeNotifier {
  List<VehicleModelName> _models = [];
  bool _isLoading = false;

  List<VehicleModelName> get models => _models;
  bool get isLoading => _isLoading;

  Future<void> getModel(Vehicle vehicle) async {
    final url = Uri.parse("${Urls.getModel}${vehicle.vehicleType.id}/${vehicle.brand.id}");
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
        final Map<String, dynamic> data = json.decode(response.body);
        print("vehicle model: $data");

        final List<VehicleModelName> models = (data['data'] as List)
            .map((item) => VehicleModelName.fromJson(item))
            .toList();

        _models = models;

        notifyListeners();
      } else {
        print('vehicle model download failed: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
