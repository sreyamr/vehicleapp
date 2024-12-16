import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicleapp/providers/total_vehicle_provider.dart';

import '../config/approutes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.pushNamed(context, AppRoutes.requirement);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final totalVehicleProvider =
      Provider.of<TotalVehicleProvider>(context, listen: false);
      totalVehicleProvider.getTotalVechileList();
    });

    final List<Widget> _screens = [
      // Home Screen
      Consumer<TotalVehicleProvider>(
        builder: (context, totalVehicleProvider, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await totalVehicleProvider.getTotalVechileList();
            },
            child: totalVehicleProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
              padding: const EdgeInsets.all(12.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.8, // Adjust height-to-width ratio
              ),
              itemCount: totalVehicleProvider.vehicle.length,
              itemBuilder: (context, index) {
                final vehicle = totalVehicleProvider.vehicle[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.vehicleDetails,arguments: vehicle);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              radius: 50, // Adjust the radius as needed
                              backgroundImage: NetworkImage(
                                vehicle.images.isNotEmpty ? vehicle.images[0].imageUrl : 'default_image_url',
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Vehicle Unique ID
                                Text(
                                  vehicle.id.toString(),
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                // Price
                                Text(
                                  vehicle.price.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 4.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),

      const Center(child: Text("Messages Screen")),

      const Center(child: Text("Profile Screen")),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu),
        actions: const [Icon(Icons.notifications_active)],
        title: const Text("Vehicles List"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(color: Colors.brown,fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        showUnselectedLabels: true,
        currentIndex: _selectedIndex, // Set the currently selected index
        onTap: _onItemTapped, // Handle tab selection
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.brown),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message,color: Colors.brown),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,color: Colors.brown),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment,color: Colors.brown),
            label: 'Requirements', // New button added
          ),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
