import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart'; 
import 'screens/register_screen.dart'; 
import 'screens/home_screen.dart'; 
import 'screens/restaurant_screen.dart';
import 'screens/menu_screen.dart'; 
import 'screens/cart_screen.dart'; 
import 'screens/delivery_info_screen.dart';
import 'screens/order_status_screen.dart';
import 'screens/review_screen.dart';
import 'screens/search_screen.dart';
import 'screens/fortune_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Firebase initialization for all platforms
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print("Firebase initialized successfully.");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Firebase initialization error: $e");
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Project Phase 2",
      initialRoute: "/Login",
      routes: {
        "/Login": (context) => LoginScreen(),
        "/Register": (context) => RegisterScreen(),
        "/Home": (context) => HomeScreen(),
        "/Fortune": (context) => FortuneScreen(),
        "/Profile": (context) => ProfileScreen(),
        "/Search": (context) => SearchScreen(),
        "/Restaurant": (context) => RestaurantScreen(),
        "/Menu": (context) => MenuScreen(),
        "/Sepet": (context) => CartScreen(),
        "/DeliveryInfo": (context) => DeliveryInfoScreen(),
        "/OrderStatus": (context) => OrderStatusScreen(),
        "/Review": (context) => ReviewScreen(),
      },
    );
  }
}