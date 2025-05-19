import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';

class DeliveryInfoScreen extends StatefulWidget {
  const DeliveryInfoScreen({super.key});

  @override
  State<DeliveryInfoScreen> createState() => _DeliveryInfoScreen();
}

class _DeliveryInfoScreen extends State<DeliveryInfoScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedLocation = 'A3-A4';
  final List<String> _locations = [
    'A3-A4',
    'FENS',
    'FMAN',
    'UC'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyles.buildAppBar(
        title: "Delivery Information",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estimated time of delivery: 25 min.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Internal Phone Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Location',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedLocation,
                  isExpanded: true,
                  items: _locations.map((String location) {
                    return DropdownMenuItem<String>(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save delivery information and proceed
                  if (_phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter internal phone number.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your order is now being prepared.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pushNamed(context, '/OrderStatus');
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1C2641),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Start preparation of your order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 0,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/Home');
              break;
            case 1:
              Navigator.pushNamed(context, '/Search');
              break;
            case 2:
              Navigator.pushNamed(context, '/Fortune');
              break;
            case 3:
              Navigator.pushNamed(context, '/Profile');
              break;
          }
        },
      ),
    );
  }
}