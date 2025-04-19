import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import 'login_screen.dart';

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
      appBar: AppStyles.buildAppBar(
        title: "PROFILE",
        context: context,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isEditingName
                            ? Container(
                                constraints: const BoxConstraints(maxWidth: 150),
                                child: TextField(
                                  controller: _nameController..text = name,
                                  onSubmitted: (value) {
                                    setState(() {
                                      name = value;
                                      isEditingName = false;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    isDense: true,
                                  ),
                                ),
                              )
                            : Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                        const SizedBox(width: 5),
                        IconButton(
                          icon: Icon(Icons.edit, size: 18, color: Colors.grey[600]),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isEditingPhone
                            ? Container(
                                constraints: const BoxConstraints(maxWidth: 150),
                                child: TextField(
                                  controller: _phoneController..text = mobilePhone,
                                  onSubmitted: (value) {
                                    setState(() {
                                      mobilePhone = value;
                                      isEditingPhone = false;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    isDense: true,
                                  ),
                                ),
                              )
                            : Text(
                                mobilePhone,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                        const SizedBox(width: 5),
                        IconButton(
                          icon: Icon(Icons.edit, size: 18, color: Colors.grey[600]),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
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
                Column(children: const [Icon(Icons.star, size: 40, color: Colors.amberAccent), Text("Favorites", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent))]),
                Column(children: const [Text("Order Status", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)), Icon(Icons.assignment, color: Colors.red, size: 40)]),
                Column(children: const [Text("Points", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)), Icon(Icons.auto_awesome, color: Colors.green, size: 40), Text("Available points: 10", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 10))]),
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