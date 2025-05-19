import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/auth_provider.dart' as app_auth;  // <— alias avoids name clash
import '../services/profile_backend.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import 'login_screen.dart';
import '../selected_restaurant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  /* ---------- state ----------- */
  bool showbox = false;
  String email       = "Not Provided";
  String name        = "Not Provided";
  String surname     = "Not Provided";
  String mobilePhone = "Not Provided";

  bool isEditingName    = false;
  bool isEditingSurname = false;
  bool isEditingPhone   = false;

  final _helpController    = TextEditingController();
  final _nameController    = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController   = TextEditingController();

  /* ---------- init ----------- */
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = context.read<app_auth.AuthProvider>().user?.uid;
    if (uid == null) return;

    final data = await ProfileBackend().getUserData(uid);
    setState(() {
      email       = data['email']!;
      name        = data['name']!;
      surname     = data['surname']!;
      mobilePhone = data['phone']!;
    });

    // keep provider's copy fresh
    context.read<app_auth.AuthProvider>().updateUserData('name', name);
    context.read<app_auth.AuthProvider>().updateUserData('surname', surname);
    context.read<app_auth.AuthProvider>().updateUserData('phone', mobilePhone);
  }

  Future<void> _update({String? newName, String? newSurname, String? newPhone}) async {
    final uid = context.read<app_auth.AuthProvider>().user?.uid;
    if (uid == null) return;

    await ProfileBackend().updateUserData(uid,
        name: newName, surname: newSurname, phone: newPhone);

    // update provider immediately
    if (newName    != null) context.read<app_auth.AuthProvider>().updateUserData('name', newName);
    if (newSurname != null) context.read<app_auth.AuthProvider>().updateUserData('surname', newSurname);
    if (newPhone   != null) context.read<app_auth.AuthProvider>().updateUserData('phone', newPhone);
  }

  /* ---------- UI ----------- */
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
            /* avatar & info */
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.person, size: 28, color: Colors.blueAccent),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* email (read-only) */
                      Row(children: [
                        const Text("Email: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Expanded(
                          child: Text(
                            email,
                            style: const TextStyle(color: Colors.black87, fontSize: 16, fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 4),

                      /* editable rows */
                      _editableRow(
                        label: "Name: ",
                        isEditing: isEditingName,
                        controller: _nameController..text = name,
                        display: name,
                        onEditTap: () => setState(() => isEditingName = true),
                        onSubmit: (v) {
                          _update(newName: v);
                          setState(() { name = v; isEditingName = false; });
                        },
                      ),
                      _editableRow(
                        label: "Surname: ",
                        isEditing: isEditingSurname,
                        controller: _surnameController..text = surname,
                        display: surname,
                        onEditTap: () => setState(() => isEditingSurname = true),
                        onSubmit: (v) {
                          _update(newSurname: v);
                          setState(() { surname = v; isEditingSurname = false; });
                        },
                      ),
                      _editableRow(
                        label: "Phone: ",
                        isEditing: isEditingPhone,
                        controller: _phoneController..text = mobilePhone,
                        display: mobilePhone,
                        onEditTap: () => setState(() => isEditingPhone = true),
                        onSubmit: (v) {
                          _update(newPhone: v);
                          setState(() { mobilePhone = v; isEditingPhone = false; });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /* ------------ original static content below kept exactly the same ------------ */
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: const [
                  Icon(Icons.star, size: 40, color: Colors.amberAccent),
                  Text("Favorites", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent))
                ]),
                Column(children: const [
                  Text("Order Status", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  Icon(Icons.assignment, color: Colors.red, size: 40)
                ]),
                Column(children: const [
                  Text("Points", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  Icon(Icons.auto_awesome, color: Colors.green, size: 40),
                  Text("Available points: 10", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 10))
                ]),
              ],
            ),
            const SizedBox(height: 45),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("           Account Settings         ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () => setState(() => showbox = !showbox),
                child: const Text("                 Help Center              ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
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
                        setState(() => showbox = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Your issue has been sent!"), duration: Duration(seconds: 2)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  /* FULL LOG-OUT */
                  await FirebaseAuth.instance.signOut();
                  context.read<app_auth.AuthProvider>().clearUser();
                  SelectedRestaurant.name = null;
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (_) => false,
                  );
                },
                child: const Text("                   Log Out                    ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
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
        onTap: (i) {
          switch (i) {
            case 0: Navigator.pushNamed(context, "/Home");    break;
            case 1: Navigator.pushNamed(context, "/Search");  break;
            case 2: Navigator.pushNamed(context, "/Fortune"); break;
            case 3: break;
          }
        },
      ),
    );
  }

  /* helper producing label + editable value */
  Widget _editableRow({
    required String label,
    required bool isEditing,
    required TextEditingController controller,
    required String display,
    required VoidCallback onEditTap,
    required Function(String) onSubmit,
  }) {
    final textStyle = TextStyle(
      color: Colors.grey[700],
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        isEditing
            ? Container(
                constraints: const BoxConstraints(maxWidth: 150),
                child: TextField(
                  controller: controller,
                  onSubmitted: onSubmit,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    isDense: true,
                  ),
                ),
              )
            : Expanded(
                child: Text(
                  display,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        const SizedBox(width: 5),
        IconButton(
          icon: Icon(Icons.edit, size: 18, color: Colors.grey[600]),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: onEditTap,
        ),
      ],
    );
  }
}
