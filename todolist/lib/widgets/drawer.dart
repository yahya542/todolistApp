import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final bool isDark; // Menerima status tema (dark/light)
  final VoidCallback onToggleTheme; // Fungsi untuk toggle tema

  // Konstruktor dengan parameter
  const DrawerWidget({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Beranda', 'icon': Icons.home},
      {'title': 'Tugas', 'icon': Icons.assignment},
      {'title': 'Pengaturan', 'icon': Icons.settings},
    ];

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? 'assets/images/avResponsive.jpg'
                  : 'assets/images/carsdark.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...menuItems.map((item) {
              final title = item['title'];
              final icon = item['icon'];
        

              return Container(
                height: 70,
                child: ListTile(
                  leading: Icon(
                    icon,
                    color: isDark ? Colors.white : Colors.white,
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Tambahkan navigasi sesuai kebutuhan
                  },
                ),
              );
            }).toList(),
            // Menambahkan tombol untuk mengganti tema
            ListTile(
              leading: Icon(
                Icons.brightness_6,
                color: Colors.white
              ),
              title: Text(
                'Ganti Tema',
                style: TextStyle(color: Colors.white),
              ),
              onTap: onToggleTheme, // Memanggil fungsi untuk toggle tema
            ),
          ],
        ),
      ),
    );
  }

  /// Fungsi untuk mendapatkan gambar background berdasarkan nama menu dan tema
  
}
