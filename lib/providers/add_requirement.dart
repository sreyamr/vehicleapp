import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vehicleapp/models/vehicle_requirement.dart';
import '../config/app_controller.dart';
import '../utlis/urls.dart';

class AddRequirement with ChangeNotifier {
  bool _addSuccess = false;
  String? _errorMessage;

  bool get addSuccess => _addSuccess;
  String? get errorMessage => _errorMessage;

  Future<void> addRequirement(VehicleRequirement vehicleRequirement) async {
    final url = Uri.parse(Urls.addRequirement);
    String? token = await AppController.getToken();

    print("Sending request to: $url");

    try {

      var jsonData = json.encode(vehicleRequirement.toJson());
      print("Request data: $jsonData");


      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Response data: $data");

        _addSuccess = true;
      } else {
        print('Request failed: ${response.body}');
        _addSuccess = false;
      }

      notifyListeners();
    } catch (e) {
      print('An error occurred: $e');
      _addSuccess = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
