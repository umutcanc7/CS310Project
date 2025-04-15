import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

void main (){
  runApp(MaterialApp(
    title: "Project phase 2",
    initialRoute: "/Login",
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
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool showPassword = false;
  bool rememberMe = false;

    Future<void> _showDialog(String title, String message) async{
    bool isAndroid = Platform.isAndroid;

    return showDialog(context: context, 
    builder: (BuildContext context) {
      if (isAndroid)
      {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(onPressed: () {Navigator.pop(context);}, child: Text('OK'))
          ],
        );
      }
      else{
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(onPressed: () {Navigator.pop(context);}, child: Text('OK'))
          ],
        );
      }
    }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.indigo[900],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    "SABANCI SEPETİ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/sepet.jpg', height: 150),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: "Please enter your E-mail address",
                    filled: true,
                    fillColor: const Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  onSaved: (value) => email = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    hintText: "Please enter your password",
                    filled: true,
                    fillColor: const Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  validator: (value) {
                    if (value != null) 
                    {
                      if (value.isEmpty)
                      {
                        return 'Password is required';
                      }
                      if (value.length < 6) 
                      {
                      return 'Password too short';
                      }
                    }                  
                    return null;
                  },
                  onSaved: (value) => password = value ?? '',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Remember me?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot your password?",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Register');
                    },
                    child: const Text(
                      "Don’t have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print('Email: $email');
                      print('Password: $password');
                      print('Remember Me: $rememberMe');

                      Navigator.pushNamed(context, '/Home');
                    }
                    else 
                    {
                      _showDialog('Form Error', 'Your form is invalid');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[900],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  child: const Text("LOGIN"),
                ),
              ],
            ),
          ),
        ),
      ),
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
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String surname = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool showPassword = false;
  bool showConfirmPassword = false;

  
  Future<void> _showDialog(String title, String message) async{
    bool isAndroid = Platform.isAndroid;

    return showDialog(context: context, 
    builder: (BuildContext context) {
      if (isAndroid)
      {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(onPressed: () {Navigator.pop(context);}, child: Text('OK'))
          ],
        );
      }
      else{
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(onPressed: () {Navigator.pop(context);}, child: Text('OK'))
          ],
        );
      }
    }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.indigo[900],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    "SABANCI SEPETİ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/sepet.jpg', height: 150),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Please enter your name",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value != null)
                    {
                      if (value.isEmpty)
                      {
                        return 'Cannot leave name empty';
                      }
                    }
                  },
                  onSaved: (value) => name = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Please enter your surname",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Surname is required' : null,
                  onSaved: (value) => surname = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Please enter your E-mail address",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value != null)
                    {
                      if (value.isEmpty)
                      {
                        return 'Email is required';
                      }
                      if (!EmailValidator.validate(value))
                      {
                        return 'Invalid email';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => email = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() => showPassword = !showPassword);
                      },
                    ),
                    hintText: "Please enter your password",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                  if (value != null)
                  {
                    if (value.isEmpty)
                    {
                      return 'Cannot leave password empty';
                    }
                    if (value.length < 6)
                    {
                      return 'Too short';
                    }
                  }
                    return null;
                  },
                  onSaved: (value) => password = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: !showConfirmPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(showConfirmPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() => showConfirmPassword = !showConfirmPassword);
                      },
                    ),
                    hintText: "Please re-enter your password",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value != null)
                    {
                      if (value.isEmpty)
                      {
                        return 'Confirmation required';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => confirmPassword = value ?? '',
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Login');
                    },
                    child: const Text(
                      "Already have an account?",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (password != confirmPassword) 
                      {
                        _showDialog('Password Mismatch', 'Passwords do not match');
                        return;
                      }

                      Navigator.pushNamed(context, '/Home');
                      print('Name: $name, Surname: $surname, Email: $email, Password: $password');
                    }
                    else {
                      _showDialog('Form Error', 'Your form is invalid');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  child: const Text("REGISTER"),
                )
              ],
            ),
          ),
        ),
      ),
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