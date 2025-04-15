import 'package:flutter/material.dart';
import 'navigation_bar.dart';

void main (){
  runApp(MaterialApp(
    title: "Project phase 2",
    initialRoute: "login",
    routes:{
      "/Login":(context) => LoginScreen(), //1
      "/Register" :(context)=>RegisterScreen(), //2
      "/Home" :(context)=>HomeScreen(), //3
    

      "/Fortune" :(context)=> FortuneScreen(), //4
      "/Profile":(context)=> ProfileScreen(), //5
      "/Search" :(context)=>SearchScreen(), //6


      "/Restaurant":(context) => RestaurantScreen() , // 7
      "/Menu" :(context) => MenuScreen() , // 8
      "/Sepet" :(context) =>SepetScreen() , // 9
      "/DeliveryInfo" :(context) => DeliveryInfoScreen(), // 10
      "/OrderStatus" :(context) =>OrderStatusScreen() , // 11
      "/Review" :(context) =>ReviewScreen() , //12
      
    },
  ));
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My App')),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndexx: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        "PROFILE",
        style:TextStyle(
          color:Colors.white,
          letterSpacing: 2.0,
          fontSize: 20,
          fontWeight: FontWeight.bold),
          
          ),
          centerTitle: false,
          elevation: 10,
          shadowColor: const Color.fromARGB(255, 133, 146, 218),
          backgroundColor: const Color.fromARGB(255, 37, 57, 170),
        ),
      body: 
      Row(
        children:<Widget>[
          Expanded(flex:2,child:ColoredBox(color: const Color.fromARGB(255, 40, 50, 194))),
          Expanded(flex:10,
          child:Column(
            children: [
            Padding(padding: EdgeInsets.all(20),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 40, color: Colors.white)
                
                ),
                Column(children: [
                  Text("User_Name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:8,
                    fontWeight: FontWeight.bold
                  )
                  ),
                  Text("Mobile Phone",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:8,
                    fontWeight: FontWeight.bold
                  ))
                ]),
              ],
            )
            )
          ],)),
          Expanded(flex:2,child:ColoredBox(color:const Color.fromARGB(255, 40, 50, 194))),
        ]
      ),
      bottomNavigationBar: CustomNavBar(
  currentIndexx: 3,
  onTap: (int index) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  },
),
      );
      
  }
}


//Profile Screen
class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen(); 
}

class _ProfileScreen extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
}


//Login Screen
class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen(); 
}

class _LoginScreen extends State<LoginScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 

//Register 
class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>_RegisterScreen(); 
}

class _RegisterScreen extends State<RegisterScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 

//Fortune
class FortuneScreen extends StatefulWidget{
  const FortuneScreen({super.key});

  @override
  State<FortuneScreen> createState() =>_FortuneScreen(); 
}

class _FortuneScreen extends State<FortuneScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 


//SearchScreen
class SearchScreen extends StatefulWidget{
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>_SearchScreen(); 
}

class _SearchScreen extends State<SearchScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 

//RestaurantScreen
class RestaurantScreen extends StatefulWidget{
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() =>_RestaurantScreen(); 
}

class _RestaurantScreen extends State<RestaurantScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 

//MenuScreen

class MenuScreen extends StatefulWidget{
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() =>_MenuScreen(); 
}

class _MenuScreen extends State<MenuScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 


//SepetScreen
class SepetScreen extends StatefulWidget{
  const SepetScreen({super.key});

  @override
  State<SepetScreen> createState() =>_SepetScreen(); 
}

class _SepetScreen extends State<SepetScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 


//DeliveryInfoScreen
class DeliveryInfoScreen extends StatefulWidget{
  const DeliveryInfoScreen({super.key});

  @override
  State<DeliveryInfoScreen> createState() =>_DeliveryInfoScreen(); 
}

class _DeliveryInfoScreen extends State<DeliveryInfoScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 


//ReviewScreen
class ReviewScreen extends StatefulWidget{
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() =>_ReviewScreen(); 
}

class _ReviewScreen extends State<ReviewScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 


//OrderStatusScreen
class OrderStatusScreen extends StatefulWidget{
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() =>_OrderStatusScreen(); 
}

class _OrderStatusScreen extends State<OrderStatusScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
} 