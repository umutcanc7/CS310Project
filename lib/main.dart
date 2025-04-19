import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

// Cart Service to manage cart state
class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Map<String, dynamic>> _cartItems = [];
  
  List<Map<String, dynamic>> get cartItems => _cartItems;
  
  double get totalAmount => _cartItems.fold(0, (sum, item) => sum + (item["price"] as num));

  void addToCart(Map<String, dynamic> item) {
    // Check if item already exists
    final existingIndex = _cartItems.indexWhere((element) => element["name"] == item["name"]);
    if (existingIndex != -1) {
      _cartItems[existingIndex]["quantity"] = (_cartItems[existingIndex]["quantity"] ?? 1) + 1;
    } else {
      _cartItems.add({...item, "quantity": 1});
    }
  }

  void removeFromCart(String itemName) {
    _cartItems.removeWhere((element) => element["name"] == itemName);
  }

  void clearCart() {
    _cartItems.clear();
  }
}

void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Project phase 2",
    initialRoute: "/Profile",
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
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF1C2641),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/sepet.jpg', // Logoyu buraya koymalısın
                  width: 100,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'SABANCI SEPETİ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Order. Eat. Repeat!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          buildNavigationButton(context, 'RESTAURANTS', '/Restaurant'),
          buildNavigationButton(context, 'FAVOURITES', '/Favourites'),
          buildNavigationButton(context, 'ORDER STATUS', '/OrderStatus'),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              
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

  Widget buildNavigationButton(BuildContext context, String label, String routeName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(60),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF1C2641), width: 2),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}




class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  bool showbox = false;
  String name = "User_Name";
  String mobilePhone = "Mobile Phone";
  bool isEditingName = false;
  bool isEditingPhone = false;

  final TextEditingController _helpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("PROFILE", style: TextStyle(letterSpacing: 2.0, fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: false,
        elevation: 20,
        backgroundColor: const Color.fromARGB(255, 37, 57, 170),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
  children: [
    Padding(
      padding: EdgeInsets.only(right: 25),
      child: CircleAvatar(
        radius: 50,
        child: Icon(Icons.person, size: 40, color: Colors.blueAccent),
      ),
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 👤 Name Row
        Row(
          children: [
            isEditingName
                ? SizedBox(
                    width: 180,
                    child: TextField(
                      controller: _nameController..text = name,
                      onSubmitted: (value) {
                        setState(() {
                          name = value;
                          isEditingName = false;
                        });
                      },
                    ),
                  )
                : Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
            SizedBox(width: 5),
            IconButton(
              icon: Icon(Icons.edit, size: 18, color: Colors.grey[600]),
              onPressed: () {
                setState(() {
                  isEditingName = true;
                });
              },
            ),
          ],
        ),

        // 📱 Phone Row
        Row(
          children: [
            isEditingPhone
                ? SizedBox(
                    width: 180,
                    child: TextField(
                      controller: _phoneController..text = mobilePhone,
                      onSubmitted: (value) {
                        setState(() {
                          mobilePhone = value;
                          isEditingPhone = false;
                        });
                      },
                    ),
                  )
                : Text(
                    mobilePhone,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
            SizedBox(width: 5),
            IconButton(
              icon: Icon(Icons.edit, size: 18, color: Colors.grey[600]),
              onPressed: () {
                setState(() {
                  isEditingPhone = true;
                });
              },
            ),
          ],
        ),
      ],
    ),
  ],
),

            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [Icon(Icons.star, size: 40, color: Colors.amberAccent), const Text("Favorites", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent))]),
                Column(children: [Text("Order Status", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)), Icon(Icons.assignment, color: Colors.red, size: 40)]),
                Column(children: [Text("Points", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)), Icon(Icons.auto_awesome, color: Colors.green, size: 40), Text("Available points: 10", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 10))]),
              ],
            ),
            const SizedBox(height: 45),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("           Account Settings         ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showbox = !showbox;
                  });
                },
                child: const Text("                 Help Center              ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
            if (showbox)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _helpController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: "Describe your problem here...(4 lines maximum):",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, size: 20, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          showbox = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Your issue has been sent!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Text("                   Log Out                    ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/sepet.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 3,
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
              break;
          }
        },
      ),
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
                      "Don't have an account?",
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

class FortuneScreen extends StatefulWidget {
  const FortuneScreen({super.key});

  @override
  State<FortuneScreen> createState() => _FortuneScreen();
}

class _FortuneScreen extends State<FortuneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fortune",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 5,
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
        backgroundColor: const Color(0xFF1C2641),
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
class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2641),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Restaurants',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildRestaurantCard(
              context,
              'assets/kucukev.jpg',
              '/Menu', // yönlendirilecek route
            ),
            buildRestaurantCard(
              context,
              'assets/pizzabulls.jpg',
              '/Menu',
            ),
            buildRestaurantCard(
              context,
              'assets/kopuklu.jpg',
              '/Menu',
            ),
            buildRestaurantCard(
              context,
              'assets/piazza.jpg',
              '/Menu',
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 0,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/Home');
          }
        },
      ),
    );
  }

  Widget buildRestaurantCard(BuildContext context, String imagePath, String routeName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF1C2641), width: 2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
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
    {"name": "Sprite", "price": 30, "isFavorite": false},
    {"name": "Water", "price": 15, "isFavorite": false},
    {"name": "Tea", "price": 15, "isFavorite": false},
    {"name": "Cola Zero", "price": 30, "isFavorite": false},
    {"name": "Fanta", "price": 30, "isFavorite": false},
    {"name": "Coke", "price": 30, "isFavorite": false},
    {"name": "Ayran", "price": 30, "isFavorite": false},
    {"name": "Orange Juice", "price": 80, "isFavorite": false},
    {"name": "Ice Tea", "price": 30, "isFavorite": false},
  ];

  final List<Map<String, dynamic>> foodMenu = [
    {"name": "Schnitzel", "price": 120, "isFavorite": false},
    {"name": "Honey Mustard Schnitzel", "price": 130, "isFavorite": false},
    {"name": "Grilled Chicken Fillet", "price": 125, "isFavorite": false},
    {"name": "Mushroom Schnitzel", "price": 135, "isFavorite": false},
    {"name": "Chili Schnitzel", "price": 135, "isFavorite": false},
  ];

  final List<Map<String, dynamic>> foods = [
    {"name": "Meat Quesadilla", "price": 110, "isFavorite": false},
    {"name": "Chicken Quesadilla", "price": 100, "isFavorite": false},
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: const Color(0xFF1C2641),
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF1C2641),
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
        backgroundColor: isSelected ? const Color(0xFF1C2641) : Colors.grey.shade300,
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
        final bool inCart = CartService().cartItems.any((cartItem) => cartItem["name"] == item["name"]);

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
                      if (inCart) {
                        CartService().removeFromCart(item["name"]);
                      } else {
                        CartService().addToCart(item);
                      }
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
class SepetScreen extends StatefulWidget {
  const SepetScreen({super.key});

  @override
  State<SepetScreen> createState() => _SepetScreenState();
}

class _SepetScreenState extends State<SepetScreen> {
  final TextEditingController _noteController = TextEditingController();
  bool _noCutlery = false;
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2641),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please proceed with the payment',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    'Here is your order!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Cart items
                  if (_cartService.cartItems.isEmpty)
                    const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    ..._cartService.cartItems.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.monetization_on_outlined),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                if (item["quantity"] != null && item["quantity"] > 1)
                                  Text(
                                    'Quantity: ${item["quantity"]}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            '${item["price"].toStringAsFixed(1)}₺',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              setState(() {
                                _cartService.removeFromCart(item["name"]);
                              });
                            },
                          ),
                        ],
                      ),
                    )).toList(),
                  if (_cartService.cartItems.isNotEmpty) ...[
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_cartService.totalAmount.toStringAsFixed(1)}₺',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  // Note section
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      hintText: 'Add a note:',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  // Cutlery toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "I don't want plastic cutlery",
                        style: TextStyle(fontSize: 16),
                      ),
                      Switch(
                        value: _noCutlery,
                        onChanged: (value) {
                          setState(() {
                            _noCutlery = value;
                          });
                        },
                        activeColor: const Color(0xFF1C2641),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Confirm button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _cartService.cartItems.isEmpty ? null : () {
                Navigator.pushNamed(context, '/DeliveryInfo');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C2641),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBackgroundColor: Colors.grey,
              ),
              child: const Text(
                'Confirm Cart',
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


//DeliveryInfoScreen
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2641),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Delivery Information',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
                  if (_phoneController.text.isNotEmpty) {
                    Navigator.pushNamed(context, '/OrderStatus');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1C2641),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm Order',
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


//OrderStatusScreen
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2641),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ORDER STATUS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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

//ReviewScreen
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreen();
}

class _ReviewScreen extends State<ReviewScreen> {
  int speedRating = 0;
  int serviceRating = 0;
  int tasteRating = 0;
  final TextEditingController _commentController = TextEditingController();

  Widget buildRatingRow(String label, int rating, Function(int) onRatingChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => onRatingChanged(index + 1),
              child: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: const Color(0xFF1C2641),
                size: 32,
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2641),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'REVIEW YOUR DELIVERY',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'THANK YOU FOR YOUR ORDER!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            buildRatingRow('Speed', speedRating, (rating) {
              setState(() => speedRating = rating);
            }),
            buildRatingRow('Service', serviceRating, (rating) {
              setState(() => serviceRating = rating);
            }),
            buildRatingRow('Taste', tasteRating, (rating) {
              setState(() => tasteRating = rating);
            }),
            const Text(
              'Optional Comment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle submit review
                Navigator.pushNamed(context, '/Home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C2641),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit Review',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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