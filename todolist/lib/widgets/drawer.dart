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
                  ? 'assets/images/avHome.jpg'
                  : 'assets/images/transformer.jpg',
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
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...menuItems.map((item) {
              final title = item['title'];
              final icon = item['icon'];
              final bgImage = getMenuItemBgImage(title, isDark);

              return Container(
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bgImage),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(isDark ? 0.5 : 0.25),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    icon,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
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
                color: isDark ? Colors.white : Colors.black,
              ),
              title: Text(
                'Ganti Tema',
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              onTap: onToggleTheme, // Memanggil fungsi untuk toggle tema
            ),
          ],
        ),
      ),
    );
  }

  /// Fungsi untuk mendapatkan gambar background berdasarkan nama menu dan tema
  String getMenuItemBgImage(String title, bool isDark) {
    switch (title) {
      case 'Beranda':
        return isDark
            ? 'assets/images/avTop.jpeg'
            : 'assets/images/menu/bg_beranda_light.jpg';
      case 'Tugas':
        return isDark
            ? 'assets/images/avResponsive.jpg'
            : 'assets/images/menu/bg_tugas_light.jpg';
      case 'Pengaturan':
        return isDark
            ? 'assets/images/menu/bg_pengaturan_dark.jpg'
            : 'assets/images/menu/bg_pengaturan_light.jpg';
      default:
        return isDark
            ? 'assets/images/avHome.jpg'
            : 'assets/images/transformer.jpg';
    }
  }
}
