import 'package:flutter/material.dart';

import '../screens/settingScreen.dart';
import '../screens/loginScreen.dart';

void main() {
  runApp(const DrawerWidget());
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

   @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/avHome.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Text('Menu', style: TextStyle(fontSize: 24)),
          ),
          // Item pertama dengan gambar latar belakang
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/avResponsive.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.login, color: Colors.white),
              title: const Text('Masuk', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),
          // Item kedua dengan gambar latar belakang berbeda
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/anotherImage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Pengaturan', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
            ),
          ),
          // Item ketiga tanpa gambar latar belakang, tetap menggunakan warna latar belakang default
          ListTile(
            leading: const Icon(Icons.info, color: Colors.black),
            title: const Text('Tentang', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Aksi untuk item ini
            },
          ),
        ],
      ),
    );
  }
}