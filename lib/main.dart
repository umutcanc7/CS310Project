import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Project phase 2",
    initialRoute: "/Menu",
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
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> results = [];
  final List<Map<String, dynamic>> drinks = [
    {"name": "Sprite", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Water", "price": 15, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Tea", "price": 15, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Cola Zero", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Fanta", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Coke", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Ayran", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Orange Juice", "price": 80, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Ice Tea", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
  ];

  final List<Map<String, dynamic>> foodMenu = [
    {"name": "Schnitzel", "price": 120, "type": "menu", "isFavorite": false, "inCart": false},
    {"name": "Honey Mustard Schnitzel", "price": 130, "type": "menu", "isFavorite": false, "inCart": false},
    {"name": "Grilled Chicken Fillet", "price": 125, "type": "menu", "isFavorite": false, "inCart": false},
    {"name": "Mushroom Schnitzel", "price": 135, "type": "menu", "isFavorite": false, "inCart": false},
    {"name": "Chili Schnitzel", "price": 135, "type": "menu", "isFavorite": false, "inCart": false},
  ];

  final List<Map<String, dynamic>> foods = [
    {"name": "Meat Quesadilla", "price": 110, "type": "food", "isFavorite": false, "inCart": false},
    {"name": "Chicken Quesadilla", "price": 100, "type": "food", "isFavorite": false, "inCart": false},
  ];

  @override
  void initState() {
    super.initState();
    final allItems = [...drinks, ...foodMenu, ...foods];
    results = allItems;
  }
  void updateSearch(String query) {
    final search = query.toLowerCase();
    final allItems = [...drinks, ...foodMenu, ...foods];
    setState(() {
      if (search.isEmpty) {
        results = allItems;
      } else {
        results = allItems
            .where((item) => item["name"].toString().toLowerCase().contains(search))
            .toList();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: updateSearch,
              decoration: InputDecoration(
                hintText: "Search for drinks, foods, or menus...",
                filled: true,
                fillColor: Colors.grey.shade200,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                final bool isFavorite = item["isFavorite"] ?? false;
                final bool inCart = item["inCart"] ?? false;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(item["name"], style: const TextStyle(fontSize: 16)),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            item["isFavorite"] = !isFavorite;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          inCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            item["inCart"] = !inCart;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 1, // 1 = Search tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/Home");
              break;
            case 1:
              Navigator.pushNamed(context, "/Search");
              break;
            case 2:
              Navigator.pushNamed(context, "/Fortune");
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

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedCategory = 1; // 0: Food, 1: Drinks, 2: Food(Menu)

  final List<Map<String, dynamic>> drinks = [
    {"name": "Sprite", "price": 30, "isFavorite": false, "inCart": false},
    {"name": "Water", "price": 15, "isFavorite": false, "inCart": false},
    {"name": "Tea", "price": 15, "isFavorite": false, "inCart": false},
    {"name": "Cola Zero", "price": 30, "isFavorite": false, "inCart": false},
    {"name": "Fanta", "price": 30, "isFavorite": false, "inCart": false},
    {"name": "Coke", "price": 30, "isFavorite": false, "inCart": false},
    {"name": "Ayran", "price": 30, "isFavorite": false, "inCart": false},
    {"name": "Orange Juice", "price": 80, "isFavorite": false, "inCart": false},
    {"name": "Ice Tea", "price": 30, "isFavorite": false, "inCart": false},
  ];

  final List<Map<String, dynamic>> foodMenu = [
    {"name": "Schnitzel", "price": 120, "isFavorite": false, "inCart": false},
    {"name": "Honey Mustard Schnitzel", "price": 130, "isFavorite": false, "inCart": false},
    {"name": "Grilled Chicken Fillet", "price": 125, "isFavorite": false, "inCart": false},
    {"name": "Mushroom Schnitzel", "price": 135, "isFavorite": false, "inCart": false},
    {"name": "Chili Schnitzel", "price": 135, "isFavorite": false, "inCart": false},
  ];

  final List<Map<String, dynamic>> foods = [
    {"name": "Meat Quesadilla", "price": 110, "isFavorite": false, "inCart": false},
    {"name": "Chicken Quesadilla", "price": 100, "isFavorite": false, "inCart": false},
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue.shade900,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Menu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade900,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCategoryButton("Food", 0),
                const SizedBox(width: 10),
                buildCategoryButton("Drinks", 1),
                const SizedBox(width: 10),
                buildCategoryButton("Food (Menu)", 2),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: getSelectedMenu(),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/Sepet");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Go To Your Cart!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(
          currentIndexx: 1, // ← you can change this based on the screen index
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, "/Home");
                break;
              case 1:
                Navigator.pushNamed(context, "/Search");
                break;
              case 2:
                Navigator.pushNamed(context, "/Fortune");
                break;
              case 3:
                Navigator.pushNamed(context, "/Profile");
                break;
            }
          },
        ),
      ),
    );
  }

  Widget buildCategoryButton(String title, int index) {
    bool isSelected = selectedCategory == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue.shade900 : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(title),
    );
  }

  Widget getSelectedMenu() {
    List<Map<String, dynamic>> selectedList;
    if (selectedCategory == 0) {
      selectedList = foods;
    } else if (selectedCategory == 1) {
      selectedList = drinks;
    } else {
      selectedList = foodMenu;
    }

    return ListView.builder(
      itemCount: selectedList.length,
      itemBuilder: (context, index) {
        final item = selectedList[index];
        final bool isFavorite = item["isFavorite"] ?? false;
        final bool inCart = item["inCart"] ?? false;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  item["name"],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedList[index]["isFavorite"] = !isFavorite;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "${item["price"]}₺",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    inCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedList[index]["inCart"] = !inCart;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
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