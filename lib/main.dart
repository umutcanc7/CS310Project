import 'package:flutter/material.dart';
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

void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Project phase 2",
    initialRoute: "/Login",
    routes:{
      "/Login":(context) => LoginScreen(), //1
      "/Register" :(context)=>RegisterScreen(), //2
      "/Home" :(context)=>HomeScreen(), //3
    

      "/Fortune" :(context)=> FortuneScreen(), //4
      "/Profile":(context)=> ProfileScreen(), //5
      "/Search" :(context) =>SearchScreen(), //6


      "/Restaurant":(context) => RestaurantScreen() , // 7
      "/Menu" :(context) => MenuScreen() , // 8
      "/Sepet" :(context) =>CartScreen() , // 9
      "/DeliveryInfo" :(context) => DeliveryInfoScreen(), // 10
      "/OrderStatus" :(context) =>OrderStatusScreen() , // 11
      "/Review" :(context) =>ReviewScreen() , //12
      
    },
  ));
}

