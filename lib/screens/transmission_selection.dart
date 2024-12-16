import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/transmission_model.dart';
import '../models/vehicle_model.dart';

class TransmissionSelection extends StatefulWidget {
  final List<Transmission> transmissions;

  TransmissionSelection({required this.transmissions});

  @override
  _TransmissionSelectionState createState() => _TransmissionSelectionState();
}

class _TransmissionSelectionState extends State<TransmissionSelection> {
  String? _selectedTransmission;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.transmissions.map((transmission) {
        bool isSelected = _selectedTransmission == transmission.name;

        return Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? Colors.brown[900] : Colors.grey[200],
              foregroundColor: isSelected ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _selectedTransmission = transmission.name;
              });
            },
            child: Text(transmission.name.toString()),
          ),
        );
      }).toList(),
    );
  }
}
