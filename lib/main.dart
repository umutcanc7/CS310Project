import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
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
import 'screens/menu1.dart';
import 'screens/menu2.dart';
import 'screens/menu3.dart';
import 'screens/forgot_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Project Phase 2",
      initialRoute: "/Login",
      routes: {
        "/Login": (context) => const LoginScreen(),
        "/Register": (context) => const RegisterScreen(),
        "/Home": (context) => const HomeScreen(),
        "/Fortune": (context) => const FortuneScreen(),
        "/Profile": (context) => const ProfileScreen(),
        "/Search": (context) => const SearchScreen(),
        "/Restaurant": (context) => const RestaurantScreen(),
        "/Menu": (context) => const MenuScreen(),
        "/Menu1": (context) => const Menu1Screen(),
        "/Menu2": (context) => const Menu2Screen(),
        "/Menu3": (context) => const Menu3Screen(),
        "/Sepet": (context) => const CartScreen(),
        "/DeliveryInfo": (context) => const DeliveryInfoScreen(),
        "/OrderStatus": (context) => const OrderStatusScreen(),
        "/Review": (context) => const ReviewScreen(),
        "/ForgotPassword": (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
