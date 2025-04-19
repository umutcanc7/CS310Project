import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';

class FortuneScreen extends StatefulWidget {
  const FortuneScreen({super.key});

  @override
  State<FortuneScreen> createState() => _FortuneScreen();
}

class _FortuneScreen extends State<FortuneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyles.buildAppBar(
        title: "Fortune",
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/hamburger.jpg', height: 40),
                      Image.asset('assets/kola.jpeg', height: 40),
                      Image.asset('assets/plus.jpeg', height: 30),
                      Image.asset('assets/pizza.jpeg', height: 40),
                      Image.asset('assets/pie.jpeg', height: 40),
                      Image.asset('assets/kola.jpeg', height: 40),
                    ],
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 0,
                  child: Image.asset('assets/sale.png', height: 40),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/pizza.jpeg', height: 40),
                      Image.asset('assets/pie.jpeg', height: 40),
                      Image.asset('assets/plus.jpeg', height: 30),
                      Image.asset('assets/waffle.jpeg', height: 40),
                      Image.asset('assets/kola.jpeg', height: 40),
                      Image.asset('assets/suffle.jpeg', height: 40),
                    ],
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 0,
                  child: Image.asset('assets/limitedoffer.jpeg', height: 40),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/Home");
              break;
            case 1:
              Navigator.pushNamed(context, "/Search");
              break;
            case 2:
              break;
            case 3:
              Navigator.pushNamed(context, "/Profile");
              break;
          }
        },
      ),
    );
  }
}