import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreen();
}

class _OrderStatusScreen extends State<OrderStatusScreen> {
  int _currentStatus = 0; // 0: Order Picking, 1: On the way
  final List<Map<String, dynamic>> _statusSteps = [
    {
      'title': 'Order Picking',
      'estimatedTime': '3 mins',
      'icon': Icons.store
    },
    {
      'title': 'On the way',
      'estimatedTime': '10 mins',
      'icon': Icons.delivery_dining
    },
  ];

  void _updateStatus() {
    setState(() {
      if (_currentStatus < _statusSteps.length - 1) {
        _currentStatus++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyles.buildAppBar(
        title: "ORDER STATUS",
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Delivery Person Info Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2641),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF1C2641),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Arda',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Delivery boy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle phone call
                    },
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            // Status Steps
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: List.generate(_statusSteps.length, (index) {
                  final step = _statusSteps[index];
                  final isActive = index <= _currentStatus;
                  final isLast = index == _statusSteps.length - 1;

                  return GestureDetector(
                    onTap: _updateStatus,
                    child: Row(
                      children: [
                        // Status Icon Column
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isActive ? const Color(0xFF1C2641) : Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                step['icon'],
                                color: Colors.white,
                              ),
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 50,
                                color: isActive ? const Color(0xFF1C2641) : Colors.grey.shade300,
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // Status Text Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                step['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isActive ? Colors.black : Colors.grey,
                                ),
                              ),
                              Text(
                                'Estimated time: ${step['estimatedTime']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isActive ? Colors.black54 : Colors.grey,
                                ),
                              ),
                              if (!isLast) const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            // Review Order Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Review');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1C2641),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Review Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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