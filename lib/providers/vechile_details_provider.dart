import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vehicleapp/models/vehicle_model.dart';
import '../config/app_controller.dart';
import '../utlis/urls.dart';

class GetVehicleDetailsProvider with ChangeNotifier {
  List<Vehicle> _vehicle = [];
  bool _isLoading = false;

  List<Vehicle> get vehicle => _vehicle;
  bool get isLoading => _isLoading;

  Future<void> getVehicleDetails() async {
    final url = Uri.parse(Urls.getVehiclesDetails);
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
        print("Details: $data");
        _vehicle = [Vehicle.fromJson(data['data'])];
      } else {
        print('getVechile failed: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
