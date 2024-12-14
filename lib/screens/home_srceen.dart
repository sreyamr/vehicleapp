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
  int _selectedIndex = 0; // Track the selected tab index

  // Function to handle tab selection
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
    // Fetch the vehicle list when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final totalVehicleProvider =
      Provider.of<TotalVehicleProvider>(context, listen: false);
      totalVehicleProvider.getTotalVechileList();
    });

    // Define the list of screens for tab navigation
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
                    Navigator.pushNamed(context, AppRoutes.vehicleDetails);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50, // Adjust the radius as needed
                            backgroundImage: NetworkImage(
                              vehicle.images.isNotEmpty ? vehicle.images[0].imageUrl : 'default_image_url',
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
      // Messages Screen (for demonstration)
      const Center(child: Text("Messages Screen")),
      // Profile Screen (for demonstration)
      const Center(child: Text("Profile Screen")),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: const [Icon(Icons.notifications_active)],
        title: const Text("Vehicles List"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown, // Color for the selected item icon and label
        unselectedItemColor: Colors.black, // Color for the unselected item icon and label
        selectedLabelStyle: const TextStyle(color: Colors.brown), // Selected label text color
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
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
      body: _screens[_selectedIndex], // Show the corresponding screen based on selected tab
    );
  }
}
